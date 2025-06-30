// 'import' carga todas as funcións definidas con '#let' no arquivo estilo.typ
#import("estilo.typ"): *

// Varios informacions. Poden ser usados para un titulo xenerico, e pa que o
// documento teña información nos metadatos
#set document(
    title: Titulo,
    author: ("el Davis","el Internet"),
    description: "Revista de Física Compostelana",
    keywords: ("física","divulgación"),
    date: datetime( year: 1900, month: 10, day: 4)
)

// Unha das funcións cargadas de dito arquivo é 'activar_estilo'
// Véxase https://typst.app/docs/reference/styling
#show: activar_estilo

//// 'include' o que fai é executar o código do arquivo que corresponda e
// móstrao como texto normal, en vez de importar funcións ou variables
//
// Pode que seguir o método da version de LaTeX para cargar portada,indice e
// contraportada non sexa o mellor
#include("portada.typ")
#include("indice.typ")

#include("artigos/artigo_CARATHEODORY.typ")

#include("contraportada.typ")
