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
    Titulo                 : "titulo",
    Numero                 : "000",
    Data                   : datetime.today(),
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
    indice                 : none,
    portada                : none,
    contraportada          : none,
    documento, // este é un argumento posicional. É o contido de TODO o documento
) = {
    // Varias informacions. Poden ser usados para un titulo xenerico, e pa que
    // o documento teña información nos metadatos
    set document(
        title       : Titulo,
        author      : Participantes,
        description : "Revista de Física Estudantil e Compostelana",
        keywords    : ("física","divulgación"),
        date        : Data
    )

    // Modificamos os valores do ELEMENTO 'page'
    set page(
        paper: "a4",
        margin: (
            top    : 20mm,
            left   : 10mm,
            right  : 10mm,
            bottom : 25mm
        ),
    )
    // Modificamos os valores do ELEMENTO 'text'
    set text(
        size: 10pt,
        font: "New Computer Modern",// Por desgracia, por agora non hai maneira de usar tipografías
        lang: "gl",                 // nun directorio concreto tendo a súa ruta (sí se pode cunha
        ligatures: true,            // opción do compilador, pero é un rollo)
    )
    // Modificamos os valores do ELEMENTO 'par'
    set par( justify: true, first-line-indent: 0mm)
    // O texto tipo 'verbatim', non é un ELEMENTO básico de typst, polo que non
    // podemos facer 'set raw' como cos anteriores, hai que facer 'show'. En
    // realidade, o tema de set/show é algo confuso ao principio, deixo un
    // comentario de Reddit:
    // https://www.reddit.com/r/typst/comments/18ycvqz/letsetshow_confusion/
    show raw: set text(
        font: "New Computer Modern Mono",
        ligatures: true,
    )
    // As citas textuais esas
    show quote: it => {
        set quote(block: true)
        set text(style:"italic")
        it
    }
    // Con 'show' podemos afectar a poucas cousas directamente. Hai que montar
    // unha parrallada cun contexto
    // Ver https://forum.typst.app/t/how-to-customize-the-styling-of-caption-supplements/976/6
    show figure.caption: it => {
        set align(left)
        set text(font:"New Computer Modern Sans")
        { context strong[#it.supplement~#it.counter.display() #it.separator] }
        it.body
    }

    // Estamos no corpo da función 'activar_estilo'. Ésta función ten variedade
    // de argumentos con nome (Titulo,Data, etc.) e un so posicional (que eu
    // chamo 'documento'). En concreto, os argumentos 'portada', 'indice',
    // 'documento' e 'contraportada' poden ser funcións (calquera o pode ser).
    // Pois o que fago é rular ditas funcións para activar as partes do
    // documento

    // Por defecto 'none', en cada revista hai que facer:
    // 'activar_estilo.with(porttada: funcion_para_mostrar_a_portada())
    portada

    // Por defecto 'none'
    indice

    // Este era un argumento posicional. Ao usar a función 'activar_estilo' nun
    // #show, é dicir, ao facer
    //
    // #show: activar_estilo()
    //
    // pásaselle automáticamente o contido total do documento (dende onde se
    // chama en adiante) á función 'activar_estilo', como argumento posicional.
    // Para mostralo, devolvémolo aquí
    documento

    // Por defecto 'none'
    contraportada
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
        header: grid(
            columns: (1fr, 2.3cm, 1fr),
            rows: (1em,1em,1em),
            row-gutter: 0pt,
            // stroke: (thickness:0.1pt, dash:"dashed"),
            align: (left+horizon, center+horizon, right+horizon ),

            grid.cell( x:0,y:0, Estilo),

            grid.cell( x:0,y:1, line(length:100%, stroke:0.2pt)),

            grid.cell( x:2,y:1, line(length:100%, stroke:0.2pt)),

            grid.cell(
                x:1,
                rowspan:3,
                circle(
                    fill:red,
                    radius: 1.4em,
                    text(
                        fill:white,
                        size:22pt,
                        [$accent(m,arrow,size:#155% )$]
                    )
                )
            )

        )
    )
    /// Como comentei antes no dos estados, necesito actualizar o valor de
    // 'artigos' manualmente. Engádolle un array co titulo do artigo presente
    // e súa autoría
    artigos.update(eu => eu + (Titulo, Autoria),)
    // E mostro o propio titular

    // TITULO
    text(
        size: 20pt,
        fill: rgb(Color),
        weight: "bold",
        align(center)[ #heading(Titulo) ]
    )
    // AUTORÍA
    text( size: 14pt, align(center)[#Autoria])
    // SUBTITULO
    text( align(center)[#emph(Subtitulo)])
    // <paco>
    // #link(<paco>)[here]

    columns(2, gutter:5mm, artigo)
}

#let crear_portada(numero, imaxe, comentario) = {

    set page(
        paper: "a4",
        margin: (
            top : 5mm,
            left : 5mm,
            right : 5mm,
            bottom : 5mm
        ),
    )

    //// Non me acaba de quedar claro as diferentes formas de colocar as cousas,
    // con place,move,box etc. Nin qué é a opción de 'float'
    //
    //// Tamén estaría ben usar as variables tipo #Titulo, #Data, .etc

    // O titulo
    place(
        center + top,
        dy:1cm,
        align(center)[
            #text(
                fill: rgb("#ff0000"),
                size: 70pt,
                weight: "bold",
            )[$arrow(#text(weight:"bold")[M])$]
            #text(
                size: 70pt,
                weight: "bold",
            )[OMENTUM]
        ]
    )

    // Numero e data
    place(
        center + top,
        dy:4cm,
        block(
            inset: 11pt,
            stroke: 2pt,
            fill: rgb("#ff0000"),
            text(
                fill: white,
                font: "New Computer Modern Mono",
                size: 20pt,
            )[Num.#numero #h(1fr) Abril 2025],
        ),
    )

    // Imaxe da portada.
    place(
        center + top,
        dy: 5.21cm,
        block(
            inset:0.6pt,
            stroke:2pt,
            image(width: 100%, imaxe)
        )
    )

    // Comentario da imaxe
    place(
        left + top,
        dy: 24.3cm,
        dx: 0.4cm,
        rect(
            fill: rgb("#44444455"),
            text(fill:white,weight:"bold", size:11pt)[#comentario]
        )
    )

    pagebreak()
}

#let crear_indice(participantes, sobremomentum) = {

    set par(first-line-indent: 0pt)
    set page(
        background: place(
            right + top,
            rect( fill: red, height: 100%, width: 8cm)
        )
    )

    grid(
        /// Unha estructura con 3 columnas. A primeira para o indice, a segunda
        // como espaciado, e a terceira para colocar o texto encima do fondo
        // vermello ese do lado.
        columns: (1fr,1.5cm,6.2cm),
        rows: (20%,50%,30%),
        stroke: black+0.1pt,

        grid.cell(
            x:0, y:0,
            rowspan: 2,
            // Un intento de facer o indice a man, usando o estado 'artigos'. Véxase o arquivo estilo.typ
            {
                text(weight:"bold",size:20pt)[ Índice #v(0.5cm) ]
                context {
                    for artigo in artigos.final() [
                        #artigo \
                    ]
                }
            }
        ),

        grid.cell(
            x:2,y:0,
            align: center,
            text(size:15pt,fill:white)[
                #v(2em)
                5 de Abril do 2025
                #v(1em)
                Número 001
            ]
        ),

        grid.cell(
            x:2, y:1,
            align: left,
            text(fill:white)[#participantes]
        ),

        grid.cell( x:0, y:2, sobremomentum )

    )
    pagebreak()
}

#let crear_contraportada() = {
    pagebreak()
    set page(
        background: place(
            center,
            dy:10em,
            image("imaxes/fondo_contraportada.png")
        )
    )
}
