//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//  _____ ____ _____ ___ _     ___  %
// | ____/ ___|_   _|_ _| |   / _ \ %
// |  _| \___ \ | |  | || |  | | | |%
// | |___ ___) || |  | || |__| |_| |%
// |_____|____/ |_| |___|_____\___/ %
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

// Estilo xeral que aplica a TODA a revista. Fonte por defecto, algúns
// metadatos, data, etc.
#let estilo_xeral(
    participantes : none,
    data          : none,
    doc,
) = {
    set document(
        title       : "Revista Estudantil Momentum",
        author      : participantes.map(p => p.nome),
        description : "Revista de Física Estudantil e Compostelana",
        keywords    : ("física","divulgación","galego"),
        date        : data
    )
    set page(
        paper   : "a4",
        // binding : left,
    )
    set text(
        size      : 10pt,
        font      : "New Computer Modern",
        lang      : "gl",
        weight    : 550,
        fallback  : false,
        style     : "normal",
        features  : ( liga : 1, kern : 1,),
        overhang  : true,
        region    : "ES",
        script    : "latn",
        dir       : ltr,
        hyphenate : true,
    )
    show math.equation: set text(font: "New Computer Modern Math")
    doc
}

// Estilo para a portada.
#let estilo_portada(doc) = {
    set page(
        margin: (
            top    : 5mm,
            left   : 5mm,
            right  : 5mm,
            bottom : 5mm,
        ),
    )
    doc
}

// Función para crear a portada
#let crear_portada(
    numero      : none,
    imaxe       : none,
    comentario  : none,
    cor         : none,
    cor_inverso : none,
    data        : none
) = {
    // O titulo
    place(
        center + top,
        dy:1cm,
        align(center)[
            #set text(weight: "bold")
            #show math.equation: set text(weight: "bold")
            #text( fill: cor, size: 70pt)[$arrow("M")$]
            #text( size: 70pt)[OMENTUM]
        ]
    )
    // Numero e data
    place(
        center + top,
        dy:4cm,
        block(
            inset  : 11pt,
            stroke : 2pt,
            fill   : cor,
            text(
                fill : cor_inverso,
                font : "New Computer Modern Mono",
                size : 20pt,
            )[Num.#numero #h(1fr) #data],
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
            fill: rgb("#44444499"),
            text(
                fill   : white,
                weight : "bold",
                size   : 11pt,
                font   : "New Computer Modern Sans",
            )[#comentario]
        )
    )
}

// Estilo para o índice de contidos
#let estilo_indice(
    cor         : none,
    cor_inverso : none,
    doc,
) = {
    set par(first-line-indent: 0pt)
    set page(
        background : place(
            right + top,
            rect(fill: cor, height: 100%, width: 8cm),
        ),
        margin: (
            top    : 20mm,
            left   : 10mm,
            right  : 10mm,
            bottom : 25mm
        ),
    )
    show grid.cell: eso => {
        if eso.x == 2 {
            set text(font: "New Computer Modern Sans", fill: cor_inverso)
            eso
        } else {
            eso
        }
    }
    doc
}

// Función para crear o propio índice de contidos
#let artigos = state("artigos", ())
#let crear_indice(
    participantes : none,
    cor_inverso   : none
) = {
    grid(

        columns : (1fr, 1.5cm, 6.2cm),
        rows    : (20%,   50%,   30%),
        // stroke  : (paint: black, thickness: 0.6pt, dash: "loosely-dashed"),

        grid.cell(
            x:0, y:0,
            rowspan: 3,
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
            [
                #set text( size : 15pt )
                #v(2em)
                5 de Abril do 2025
                #v(1em)
                Número 001
            ]
        ),

        grid.cell(
            x:2, y:1,
            align: left,
            {
                set text( size : 12pt )
                for p in participantes {
                    [#p.nome \ ]
                }
            }
        ),

    )
}

// Estilo para a contraportada
#let estilo_contraportada(doc) = {
    doc
}

// Función para crear a contraportada
#let crear_contraportada() = {
    set page(
        background: place(
            center,
            dy : 10em,
            image("imaxes/fondo_contraportada.png")
        )
    )
    [ #v(1em) ]
}



#let estilo_corpo(doc) = {
    set page(
        margin: (
            top    : 20mm,
            left   : 10mm,
            right  : 10mm,
            bottom : 25mm
        ),
    )
    set par(
        justify           : true,
        linebreaks        : "optimized",
        first-line-indent : 0mm,
    )
    show raw: set text(
        font: "New Computer Modern Mono",
        ligatures: true,
    )
    show quote: it => {
        set quote(block: true)
        set text(style:"italic")
        it
    }
    show figure.caption: it => {
        set align(left)
        set text(font:"New Computer Modern Sans")
        { context strong[#it.supplement~#it.counter.display() #it.separator] }
        it.body
    }
    doc
}

#let crear_revista(
    numero          : "-- SEN NÚMERO --",
    data            : datetime.today(),
    cor             : rgb("ff0000"),
    cor_inverso     : rgb("ffffff"),
    imaxe           : "negro.png",
    comentario      : "-- SEN COMENTARIO --",
    linkrepositorio : "https://github.com/fisicaUSC/revista",
    whatsapp        : "https://chat.whatsapp.com/E900g1Bq7QT5ZKeuiIpxTk",
    drive           : "https://www.usc.gal/gl/centro/facultade-fisica/revista-estudantil-momentum",
    correo          : "revistafisicausc@gmail.com",
    participantes   : ((nome: "-- SEN PARTICIPANTES --"),),
    despedida       : "-- SEN DESPEDIDA --",
    agradecementos  : "-- SEN AGRADECEMENTO --",
    artigos         : "-- SEN ARTIGOS --"
) = {

    // Activamos o estilo xeral, que vai afectar a toda a revista
    show: estilo_xeral.with(
        participantes : participantes,
        data          : data,
    )

    // Agora, activamos o estilo da portada e mostrámola
    {
        show: estilo_portada
        crear_portada(
            numero      : numero,
            imaxe       : imaxe,
            cor         : cor,
            cor_inverso : cor_inverso,
            comentario  : comentario,
            data        : data.display("[month repr:long] [year]")
        )
    }

    // Activamos o estilo do índice e creámolo
    {
        show: estilo_indice.with(
            cor         : cor,
            cor_inverso : cor_inverso,
        )
        crear_indice(
            participantes : participantes,
            cor_inverso   : cor_inverso,
        )
    }

    // Activamos o estilo para os artigos (corpo) e mostrámolos
    {
        show: estilo_corpo
        artigos
    }

    // Activamos o estilo para a contraportada e creámola
    {
        show: estilo_contraportada
        crear_contraportada()
    }

}


#let Titular(
    Titulo    : "Titulo",
    Subtitulo : "Subtitulo",
    Autoria   : "Autoría",
    Estilo    : "estilo",
    Color     : "#ff00ff",
    artigo
) = {
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

    artigos.update(eu => eu + (Titulo, Autoria),)

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
