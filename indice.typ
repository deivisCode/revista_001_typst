#import("estilo.typ"): *

#set page(
    background: place(
        right + top, rect(
            fill: red,
            height: 100%,
            width: 8cm,
        )
    )
)

#grid(
    /// Unha estructura con 3 columnas. A primeira para o indice, a segunda
    // como espaciado, e a terceira para colocar o texto encima do fondo
    // vermello ese do lado.
    columns: (1fr,1.5cm,6.2cm),
    rows: (20%,50%,30%),
    // stroke: black+1pt,
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
        text(fill:white)[
            #text(size:15pt)[*Dirección*]

            Álvaro Pallas Otero      \
            Sebastián Táboas Pazo    \
            Celia Álvarez Álvarez    \
            Daniel Vázquez Lago      \

            #text(size:15pt)[*Edición*]

            David Cotelo Varela      \
            Víctor Díaz Díaz         \
            Daniel Vázquez Lago      \
            Manuel Vázquez Carreira  \
            Ana Díaz Caride          \
            Cristóbal Santos Sánchez \
            Mauro Garrido Rodríguez  \

            #text(size:15pt)[*Deseño de Logo*]

            Ana Díaz Caride          \
        ]
    ),
    grid.cell(
        x:0, y:2,
        [
            #text(fill:red,size:20pt,weight:"bold")[Sobre Momentum]
            #v(1cm)
            Tras uns cantos meses de traballo, por fin podemos dar saída á nova revista
            estudantil _Momentum_, unha revista que busca ser un medio de comunicación
            tanto dentro coma fóra da facultade de física onde expor os intereses
            científicos do estudantado. Cuestións de Divulgación, Actualidade, Entrevistas,
            Historia, Filosofía da Ciencia, Opinión, Programación... Son todos temas que
            teñen cabida dentro deste proxecto. Esta revista está realizada integramente
            polo estudantado da Facultade de Física USC, onde pretendemos ter un recuncho
            de expresión máis aló do estrictamente académico. Fundada no ano
            2025 co obxectivo de persistir na historia, esforzámonos sempre en
            mellorar. Non dubidedes en deixar a vosa pegada!
        ]
    )

)


#pagebreak()
