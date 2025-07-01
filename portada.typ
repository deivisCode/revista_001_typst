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
        // Ollo, existe un pequeno erro polo que a tipografía de texto normal
        // usada dentro do modo matemáticas non se ve igual que a mesma
        // tipografía fora do modo matemáticas. Véxase:
        // https://github.com/typst/typst/issues/366
        #text(fill:rgb("#ff0000"))[$arrow("M")$]OMENTUM
    ]
)

#v(4em)


// Numero e data
#place(
    center,
    dy:-0.9cm,
    rect(
        inset:8pt,
        stroke:1.2pt,
        fill:rgb("#ff0000"),
        text(fill:white,size:17pt)[`Num. 001` #h(1fr) `Abril 2025`]
    )
)

// Imaxe da portada.
#place(
    center,
    rect(
        inset:0.6pt,
        stroke:1.2pt,
        image(width: 100%, "imaxes/pedra.jpg")
    ),
)

// Borde
// #let thing(body) = context {
//     let size = measure(body)
//     [Width of "#body" is #size.width]
// }

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
