//// Estilo xeral, véxase
// https://typst.app/docs/tutorial/making-a-template/
// https://forum.typst.app/t/how-can-i-create-a-set-of-shared-set-and-show-rules-which-can-be-imported-into-a-theme/1292
//
//// Pode que sea mellor meter estas cousas noutro ficheiro e importalo, e
// separar así 'estilo', como tamaños e tipografías, de 'funcións' e resto de
// macros. O tema de xerar unha plantilla é moi diferente que en LaTeX
//
//// Sintaxes equivalentes para definir funcions:
// #let f = (name) => "Hello, " + name
// #let f(name) = "Hello, " + name
//
//// Tamén se pode devolver 'contido' con 'activar_estilo(it)= [ ...#it ]'
//
//// Podemos meter argumentos predefinidos (it, nome:"davis"). Logo facer
// activar_estilo.with(nome:"outro nome")
#let activar_estilo(
    /// :FACER: Non me queda claro se debería meter estos argumentos aquí. Non
    // permite usar logo cousas como #Titulo en calquera sitio. Debería
    // remiralo
    Titulo                 : "Momentum",
    Numero                 : "001",
    Data                   : "Abril 2025",
    Dia                    : "5",
    Mes                    : "Abril",
    Ano                    : "2025",
    ImaxePortada           : "./revistas/001/imaxes/cern.png",
    ComentarioImaxePortada : "comentario",
    CorResalte             : "ff0000",
    CorTextoEnResalte      : "000000",
    LinkRepositorio        : "guthib.com",
    WhatsApp               : "link.whatsapp.com",
    Drive                  : "linkaodrive.com",
    Correo                 : "correo@correo.com",
    SobreMomentum          : "Esta é a revista momentum!",
    Participantes          : "Fulano e Mengano",
    Despedida              : "Adeus! ",
    Agradecementos         : "Grazas! ",
    documento,
) = {
    // Varias informacions. Poden ser usados para un titulo xenerico, e pa que
    // o documento teña información nos metadatos
    set document(
        title: Titulo,
        author: ("el Davis","el Internet"),
        description: "Revista de Física Compostelana",
        keywords: ("física","divulgación"),
        date: datetime( year: 1900, month: 10, day: 4)
    )

    // Modificamos os valores do ELEMENTO 'page'
    set page(
        paper: "a4",
        margin: (
            top: 20mm,
            left: 10mm,
            right: 10mm,
            bottom: 25mm
        ),
    )
    // Modificamos os valores do ELEMENTO 'text'
    set text(
        size: 10pt,
        // Por desgracia, por agora non hai maneira de usar tipografías nun
        // directorio concreto tendo a súa ruta (sí se pode cunha opción do
        // compilador, pero é un rollo)
        font: "Latin Modern Roman",
        lang: "gl",
        ligatures: true,
    )
    // Modificamos os valores do ELEMENTO 'par'
    set par(
        justify: true
        // first-line-indent: 5mm,
    )
    // O texto tipo 'verbatim', non é un ELEMENTO básico de typst, polo que non
    // podemos facer 'set raw' como cos anteriores, hai que facer 'show'
    show raw: set text(
        font: "Latin Modern Mono",
        ligatures: true,
    )
    // As citas textuais esas
    set quote(block: true)
    show quote: set text(style:"italic")
    // Con 'show' podemos afectar a poucas cousas directamente. Hai que montar
    // unha parrallada cun contexto
    show figure.caption: set text(font:"New Computer Modern Sans")
    // Ver https://forum.typst.app/t/how-to-customize-the-styling-of-caption-supplements/976/6
    show figure.caption: it => context {
        strong[
            #it.supplement~#it.counter.display() #it.separator
        ]
        it.body
    }

    documento
}

/// Aquí unha cousa interesante. Typst usa funcións puras, polo que unha certa
// función non pode cambiar os valores de varibles fora do seu entorno. Por
// exemplo, se temos:
//
// #let a = 0
//
// Logo non podemos facer unha funcion como
//
// #let suma2(x) { a = x + 1 }
//
// a cal incrementa o valor da variable 'a' Typst é unha linguaxe con funcións
// puras. En caso de chamar á función 'suma2' consecutivamente, devolvería
// resultados diferentes, polo que ao meterlle o mesmo argumento a 'suma2', o
// argumento 'a', obtemos cousas diferentes. Esto en typst non está permitido,
// e da erro (supuestamente cun bo motivo). O que hai que facer é definir un
// 'estado':
//
// #let a = state("id", 0 )
//
// Onde "id" é unha cadena calquera para identificar a variable, e 0 pode ser
// calquera valor de calquer tipo, o inicial. Non se cambia o valor da
// variable, ACTUALIZASE o estado, facendo
//
// #a.update(self + 2)
//
// para sumarlle 2, por exemplo. 'self' é calquera nome. O que faremos agora é
// crear un estado que iremos actualizando engadíndolle arrays. Esto faise cada
// vez que chamemos á función "Titular", na cal temos
//
// artigos.update(it => it + (Titulo, Autoria),)
//
// Ao final, se queremos recuperar o valor do estado, hai que facer
//
// #context{ artigos.final() }
//
// '#context' úsase porque o valor de artigos.final() necesita ser executado
// dentro dun contexto (a min non me miredes, buscaque que é un contexto en
// typst mellor). '.final()' é sinxelo de entender neste caso. Queremos o valor
// de 'artigos' logo de que se actualizase todas as veces no documento, é
// dicir, logo de que fose chamado todas as veces pola función "Titular". Imos
// cargar o valor de 'artigos' ao COMEZO de todo, ANTES de actualizar seu valor
// ningunha vez, polo que necesitamos .last para que lea todas as
// actualizacións
//
// Un rollo patatero. Inicializo o estado con valor inicial dun array baleiro.
// Logo no índice obteño os valores con artigos.last() dentro dun contexto
#let artigos = state("artigos", ())

// O Macro titular tipico da nosa revista
#let Titular(
    Titulo    : "Titulo",
    Subtitulo : "Subtitulo",
    Autoria   : "Autoría",
    Estilo    : "estilo",
    // Non se me ocurriu como definir a cor de resale inda, xa o farei. Polo de
    // agora está hardcoded neste macro
    Color: "#ff00ff",
    /// :FACER: esto está aqui para poder facer '#show: Titular.with(...)' Non
    // sei se é a mellor maneira
    artigo
) = {
    // Por algún motivo, especificar o estilo de paxina fai que se force un
    // pagebreak. Véxase
    // https://typst.app/docs/guides/page-setup-guide/
    set page(
        header: [#Estilo] + line(length: 100%),
    )
    /// Como comentei antes no dos estados, necesito actualizar o valor de
    // 'artigos' manualmente. Engádolle un array co titulo do artigo presente
    // e súa autoría
    artigos.update(eu => eu + (Titulo, Autoria),)
    // E mostro o propio titular
    [
        // TITULO
        #text(
            size: 20pt,
            fill: rgb(Color),
            weight: "bold",
            align(center)[ #heading(Titulo) ]
        )
        // AUTORÍA
        #text( size: 14pt, align(center)[#Autoria])
        // SUBTITULO
        #text( align(center)[#emph(Subtitulo)])
        // <paco>
        // #link(<paco>)[here]
    ]
    columns(2, gutter:5mm, artigo)
}
