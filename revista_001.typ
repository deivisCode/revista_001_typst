// 'import' carga todas as funcións definidas con '#let' no arquivo estilo.typ
#import("estilo.typ"): *

// Unha das funcións cargadas de dito arquivo é 'activar_estilo'
// Véxase https://typst.app/docs/reference/styling
#show: activar_estilo.with(
    Titulo: "Momentum"
)

//// 'include' o que fai é executar o código do arquivo que corresponda e
// móstrao como texto normal, en vez de importar funcións ou variables
//
// Pode que seguir o método da version de LaTeX para cargar portada,indice e
// contraportada non sexa o mellor
#include("portada.typ")
#include("indice.typ")

#include("artigos/artigo_CARATHEODORY.typ")

#include("contraportada.typ")
