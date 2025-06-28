// Estilo xeral, véxase
// https://typst.app/docs/tutorial/making-a-template/
// https://forum.typst.app/t/how-can-i-create-a-set-of-shared-set-and-show-rules-which-can-be-imported-into-a-theme/1292
// Pode que sea mellor meter estas cousas noutro ficheiro e importalo, e
// separar así 'estilo', como tamaños e tipografías, de 'funcións' e resto de
// macros. O tema de xerar unha plantilla é moi diferente que en LaTeX
#let activar_estilo(it) = {
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
        font: "New Computer Modern",
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
        font: "FiraCode Nerd Font",
        ligatures: true,
    )
    // As citas textuais esas
    set quote(block: true)
    show quote: set text(style:"italic")
    // Como mostrar o indice
    //
    //// no OUTLINE, as ENTRADAS ca propiedade NIVEL=1, poñémoslle o texto doutro
    // modo
    show outline.entry.where( level: 1): set text(
        fill: red,
        size: 13pt,
        weight: "bold"
    )
    it
}

// Variables. Non as uso para nada inda pero bueno
#let Version = version(0, 0, 1)
#let Titulo = "Momentum"
#let Numero = "001"
#let Data = "Xaneiro do 1900"
#let ImaxePortada = "./revistas/001/imaxes/cern.png"
#let ComentarioImaxePortada = "comentario"
#let CorResalte = "ff0000"
#let CorTextoEnResalte = "000000"
#let LinkRepositorio = "guthib.com"
#let WhatsApp = "link.whatsapp.com"
#let Drive = " linkaodrive.com"
#let Correo = "correo@correo.com"
#let SobreMomentum = " Esta é a revista momentum! "
#let Participantes = " Fulano e Mengano"
#let Despedida = " Adeus! "
#let Agradecementos = " Grazas! "

// O Macro titular tipico da nosa revista
#let Titular(
    titulo    : "Titulo",
    subtitulo : "Subtitulo",
    autoria   : "Autoría",
    estilo    : "estilo",
    // Non se me ocurriu como definir a cor de resale inda, xa o farei. Polo de
    // agora está hardcoded neste macro
    color: "#ff00ff",
) = {
    // Por algún motivo, especificar o estilo de paxina fai que se force un
    // pagebreak. Véxase
    // https://typst.app/docs/guides/page-setup-guide/
    set page(
        header: [#estilo] + line(length: 100%),
        footer: line(length: 100%)
    )
    // TITULO
    text(
        size: 20pt,
        fill: rgb(color),
        weight: "bold",
        align(center)[
            #heading(titulo)
        ]
    )
    // AUTORÍA
    text(
        size: 14pt,
        align(center)[#autoria]
    )
    // SUBTITULO
    text(
        align(center)[#emph(subtitulo)]
    )
}
