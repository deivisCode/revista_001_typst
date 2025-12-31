//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//  _____ ____ _____ ___ _     ___  %
// | ____/ ___|_   _|_ _| |   / _ \ %
// |  _| \___ \ | |  | || |  | | | |%
// | |___ ___) || |  | || |__| |_| |%
// |_____|____/ |_| |___|_____\___/ %
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//
// Defínense:
//
// Funcións que aceptan contido como argumento e lle aplican un estilo:
//
//     estilo_xeral()
//     estilo_portada()
//     estilo_indice()
//     estilo_contraportada()
//     estilo_corpo()
//
// Funcións que crean dito contido
//
//     crear_portada()
//     crear_indice()
//     crear_contraportada()
//
// Función que xunta todo
//
//     crear_revista()

// Unhas variables globais
#let _cor_resalte = state("cor_resalte", "#FF0000")
#let _cor_texto_resalte = state("cor_texto_resalte", "#FF0000")
#let _artigos = state("artigos", ())

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
#let estilo_portada(
    doc,
) = {
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
    numero     : none,
    imaxe      : none,
    comentario : none,
    data       : none
) = {
    // O titulo
    place(
        center + top,
        dy:1cm,
        align(center)[
            #set text(weight: "bold")
            #show math.equation: set text(weight: "bold")
            #context { text( fill: _cor_resalte.get(), size: 70pt)[$arrow("M")$] }
            #text( size: 70pt)[OMENTUM]
        ]
    )
    // Numero e data
    place(
        center + top,
        dy:4cm,
        context {
            block(
                inset  : 11pt,
                stroke : 2pt,
                fill   : _cor_resalte.get(),
                    text(
                        fill : _cor_texto_resalte.get(),
                        font : "New Computer Modern Mono",
                        size : 20pt,
                    )[Num.#numero #h(1fr) #data]
            )
        }
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
    doc,
) = {
    set par(first-line-indent: 0pt)
    set page(
        background : context {
            place(
                right + top,
                rect(fill: _cor_resalte.get().lighten(35%), height: 100%, width: 8cm),
            )
        },
        margin: (
            top    : 20mm,
            left   : 10mm,
            right  : 10mm,
            bottom : 25mm
        ),
    )
    show grid.cell: eso => {
        if eso.x == 2 {
            context {
                set text(
                    font: "New Computer Modern Sans",
                    fill: _cor_texto_resalte.get(),
                )
                set par(spacing: 0pt)
                eso
            }
        } else {
            eso
        }
    }
    doc
}

// Función para crear o propio índice de contidos
#let crear_indice(
    numero        : none,
    participantes : none,
    correo        : none,
    instagram     : none,
    repositorio   : none,
    data          : none
) = {
    grid(

        columns : (1fr, 1.5cm, 6.2cm),
        rows    : (2cm,   1fr,   auto, auto),
        // stroke  : 1pt,

        grid.cell(
            x:0, y:0,
            rowspan: 4,
            {
                text(weight:"bold",size:20pt)[ Índice #v(0.5cm) ]
                context {
                    for artigo in _artigos.final() [
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
                #v(1em)
                #data.display("[day padding:none] de [month repr:long] do [year]") \
                Número #numero
            ]
        ),

        grid.cell(
            x:2, y:1,
            align: left,
            {
                set text( size : 1.2em )
                text(size: 1.5em)[*Dirección*]
                v(1em)
                participantes // Array de dicionarios ( (nome:"aa", posto:"bb"), (nome:"cc", posto:"dd") )
                    .filter(p => p.posto == "Dirección") // array so con participantes no posto 'Dirección'
                    .map(p => p.nome) // Devolvemos un array só cos nomes
                    .join("\n")
                v(1em)
                text(size: 1.5em)[*Edición*]
                v(1em)
                participantes
                    .filter(p => p.posto == "Edición")
                    .map(p => p.nome)
                    .join("\n")
                v(1em)
                text(size: 1.5em)[*Deseño de Logo*]
                v(1em)
                participantes
                    .filter(p => p.posto == "Deseño de Logo")
                    .map(p => p.nome)
                    .join("\n")
            }
        ),

        grid.cell(
            x: 2, y:2,
            {
                set par(spacing: 0pt)
                grid(
                    rows: (1.5cm, 1.5cm, 1.5cm),
                    columns : (100%,),
                    // stroke : 1pt,
                    {
                        h(5pt)
                        text(size: 20pt, font: "Symbols Nerd Font Mono")[]
                        v(5pt)
                        link("mailto:" + correo)[*#correo*]
                    },
                    {
                        h(5pt)
                        text(size: 20pt, font: "Symbols Nerd Font Mono")[]
                        v(5pt)
                        link("https://www.instagram.com/" + instagram)[*#instagram*]
                    },
                    {
                        set text(font: "New Computer Modern Mono")
                        h(5pt)
                        text(size: 20pt, font: "Symbols Nerd Font Mono")[]
                        v(5pt)
                        link("https://github.com/" + repositorio)[*#repositorio*]
                        v(5pt)
                        text(font: "Symbols Nerd Font Mono")[]
                        sys.inputs.at("rama")
                        [:]
                        sys.inputs.at("hash")
                        h(5pt)
                        sys.inputs.at("dirt")
                    }
                )
            }
        ),

        grid.cell(
            x: 2, y:3,
            {
                v(1em)
                image("imaxes/usc-negativo-escuro.pdf")
                v(1em)
            }
        )
    )
}

// Estilo para os artigos
#let estilo_corpo(doc) = {
    counter(page).update(1)
    set page(
        margin: (
            top    : 20mm,
            left   : 10mm,
            right  : 10mm,
            bottom : 25mm
        ),
        footer : context {
            let p = counter(page).get().first()
            [*#numbering("1",p)*]
        }
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

// Estilo para a contraportada
#let estilo_contraportada(doc) = {
    doc
}

// Función para crear a contraportada
#let crear_contraportada(
    anteriores : none,
    whatsapp   : none
) = {
    import "@preview/tiaoma:0.3.0"
    set page(
        background: place(
            center,
            dy : 10em,
            image("imaxes/fondo_contraportada.png")
        )
    )
    lorem(90)
    v(1em)
    lorem(90)
    v(1em)
    lorem(90)
    v(1fr)
    line(length: 100%)
    grid(
        columns       : 3,
        rows          : 2,
        column-gutter : 1em,
        row-gutter    : 1em,
        // stroke : red,

        grid.cell(
            x:0, y:0,
            [Edicións anteriores]
        ),

        grid.cell(
            x: 0, y:1,
            tiaoma.barcode(
                anteriores,
                "QRCode",
                options: (
                    option-1: 4, // error correction 1-4
                    option-2: 8, // detalle 1-40
                    scale: 1.5,
                ),
            )
        ),

        grid.cell(
            x:1, y:0,
            [Participa! (WhatsApp)]
        ),

        grid.cell(
            x: 1, y:1,
            tiaoma.barcode(
                whatsapp,
                "QRCode",
                options: (
                    option-1: 4,
                    option-2: 8,
                    scale: 1.5,
                ),
            )
        ),

        grid.cell(
            x:2, y:0,
            [Co financiamento de]
        ),

        grid.cell(
            x:2, y:1,
            [Alguén]
        )

    )
}

#let crear_revista(
    numero            : "-- SEN NÚMERO --",
    data              : datetime.today(),
    cor_resalte       : rgb("ff0000"),
    cor_texto_resalte : rgb("ffffff"),
    imaxe             : "negro.png",
    comentario        : "-- SEN COMENTARIO --",
    repositorio       : "fisicaUSC/revista",
    whatsapp          : "https://chat.whatsapp.com/E900g1Bq7QT5ZKeuiIpxTk",
    instagram         : "momentum.usc",
    anteriores        : "https://www.usc.gal/gl/centro/facultade-fisica/revista-estudantil-momentum",
    correo            : "revistafisicausc@gmail.com",
    participantes     : ((nome: "-- SEN PARTICIPANTES --"),),
    despedida         : "-- SEN DESPEDIDA --",
    agradecementos    : "-- SEN AGRADECEMENTO --",
    artigos           : "-- SEN ARTIGOS --",
    formato           : sys.inputs.formato
) = {

    // Gardamos o novo valor das cores para poder usalo nos artigos
    _cor_resalte.update(c => cor_resalte)
    _cor_texto_resalte.update(c => cor_texto_resalte)

    // Activamos o estilo xeral, que vai afectar a toda a revista
    show: estilo_xeral.with(
        participantes : participantes,
        data          : data,
    )

    // Para a revista completa mostramos todo
    if formato == "completa" {

        // Agora, activamos o estilo da portada e mostrámola
        {
            show: estilo_portada
            crear_portada(
                numero     : numero,
                imaxe      : imaxe,
                comentario : comentario,
                data       : data.display("[month repr:long] [year]")
            )
        }

        // Activamos o estilo do índice e creámolo
        {
            show: estilo_indice
            crear_indice(
                participantes : participantes,
                numero        : numero,
                correo        : correo,
                instagram     : instagram,
                repositorio   : repositorio,
                data          : data
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
            crear_contraportada(
                anteriores : anteriores,
                whatsapp   : whatsapp
            )
        }

    }

    // Para a versión simple mostramos so os artigos
    else if formato == "simple" {

        // Activamos o estilo para os artigos (corpo) e mostrámolos
        {
            show: estilo_corpo
            artigos
        }

    }

    // Para a impresa mostramos todo, con algúns cambios
    else if formato == "impresa" {
        {
            show: estilo_portada
            crear_portada(
                numero     : numero,
                imaxe      : imaxe,
                comentario : comentario,
                data       : data.display("[month repr:long] [year]")
            )
        }
        {
            show: estilo_indice
            crear_indice(
                participantes : participantes,
                numero        : numero,
                correo        : correo,
                instagram     : instagram,
                repositorio   : repositorio,
                data          : data
            )
        }
        {
            show: estilo_corpo
            artigos
        }
        {
            show: estilo_contraportada
            crear_contraportada(
                correo   : correo,
                whatsapp : whatsapp
            )
        }
    }

    else { panic("Formato da revista non válido") }

}


#let Titular(
    titulo    : "-- SEN TÍTULO --",
    subtitulo : "-- SEN SUBTITULO --",
    autoria   : "-- SEN AUTORÍA --",
    estilo    : "-- SEN ESTILO --",
    artigo
) = {
    set page(
        header: grid(
            columns    : (1fr, 2.3cm, 1fr),
            rows       : (1em,1em,1em),
            row-gutter : 0pt,
            align      : (left+horizon, center+horizon, right+horizon ),
            grid.cell(
                x:0, y:0,
                context {
                    set text(
                        fill   : _cor_resalte.get(),
                        font   : "New Computer Modern Sans",
                        weight : "bold",
                    )
                    estilo
                }
            ),
            grid.cell(
                x:0, y:1,
                line(length:100%, stroke:0.2pt),
            ),
            grid.cell(
                x:2, y:1,
                line(length:100%, stroke:0.2pt),
            ),
            grid.cell(
                x:1,
                rowspan:3,
                context
                {
                    circle(
                        fill   : _cor_resalte.get(),
                        radius : 1.4em,
                        text(
                            fill : _cor_texto_resalte.get(),
                            size : 22pt,
                            [$accent(m,arrow)$]
                        )
                    )
                }
            )
        )
    )
    _artigos.update(eu => eu + (titulo, autoria),)
    // TITULO
    context {
        text(
            size   : 20pt,
            fill   : rgb(_cor_resalte.get()),
            weight : "bold",
            align(center)[ #heading(titulo) ]
        )
    }
    // AUTORÍA
    text( size: 14pt, align(center)[#autoria])
    // SUBTITULO
    text( align(center)[#emph(subtitulo)])
    columns(2, gutter:5mm, artigo)
}
