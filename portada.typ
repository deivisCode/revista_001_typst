#import("estilo.typ"): *

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
#text(
    size: 70pt,
    weight: "bold",
    align(center)[
        #text(fill:rgb("#ff0000"))[M]OMENTUM
    ]
)

#v(4em)


// Numero e data
#place(
    center,
    dy:-1cm,
    rect(
        inset:10pt,
        stroke:1.2pt,
        fill:rgb("#ff0000"),
        text(stroke:white)[Num. 001 #h(1fr) Abril 2025]
    )
)

// Imaxe da portada.
#place(
    center,
    rect(
        inset: 0pt,
        stroke: 2pt,
        image(width: 100%, "imaxes/pedra.jpg"),
    ),
)

// Comentario da imaxe
#place(
    dx: 0.5cm,
    dy: 18cm,
    rect(
        fill: rgb("#44444455"),
        text(fill:white,weight:"bold")[
            1981: Primeira pedra da facultade de física
        ]
    )
)

#pagebreak()
