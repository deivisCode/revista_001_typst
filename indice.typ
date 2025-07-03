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
    // vermello ese do lado. Pode que usando grid.cell sexa máis cómodo
    // colocar as cousas
    columns: (1fr,1.5cm,6.2cm),
    rows: (70%,30%),
    stroke: black,
    // Primeira columna
    outline(
        title: [Indice basico],
        // Véxase o comentario en 'estilo.typ'
        target: figure.where(kind: "indice")
    ),
    // Segunda columna
    [],
    // Terceira columna
    [Bos días]
)

#pagebreak()
