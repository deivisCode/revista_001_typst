#import("estilo.typ"): *
#set page(
    paper: "a4",
    margin: (
        top    : 5mm,
        left   : 5mm,
        right  : 5mm,
        bottom : 5mm
    ),
)


//// Tal vez sexa mellor idea meter todo esto en funcións (posiblemente no seu propio ficheiro) e logo cargar a portada chamando a ditas funcións.
//
//// Podese gardar o tamaño das cousas como
// #let thing(body) = context {
//     let size = measure(body)
//     [Width of "#body" is #size.width]
// }
// E así podemos manexar mellor a colocación das cousas. Véxase:
// https://sitandr.github.io/typst-examples-book/book/basics/states/measure.html
//
//// Non me acaba de quedar claro as diferentes formas de colocar as cousas,
// con place,move,box etc. Nin qué é a opción de 'float'
//
//// Tamén estaría ben usar as variables tipo #Titulo, #Data, .etc

// O titulo
#place(
    center + top,
    float: true,
    align(center)[
        // Ollo, existe un pequeno erro polo que a tipografía de texto normal
        // usada dentro do modo matemáticas non se ve igual que a mesma
        // tipografía fora do modo matemáticas. Véxase:
        // https://github.com/typst/typst/issues/366
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
#place(
    top,
    float: true,
    // dy: -1cm,
    rect(
        inset: 14pt,
        stroke: 2pt,
        fill: rgb("#ff0000"),
        text(
            fill: white,
            font: "Latin Modern Mono",
            size: 20pt,
        )[Num. 001 #h(1fr) Abril 2025],
    ),
)

// Imaxe da portada.
#place(
    top,
    float: true,
    rect(
        inset:0.6pt,
        stroke:2pt,
        image(width: 100%, "imaxes/pedra.jpg")
    ),
)

// Comentario da imaxe
#place(
    top,
    float: true,
    // dx: 0.5cm,
    // dy: 18cm,
    rect(
        fill: rgb("#44444455"),
        text(fill:white,weight:"bold")[
            1981: Primeira pedra da facultade de física
        ]
    )
)

#pagebreak()
