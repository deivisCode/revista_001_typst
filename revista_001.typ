// 'import' carga todas as funcións definidas con '#let' no arquivo estilo.typ
#import("estilo.typ"): *

// Unha das funcións cargadas de dito arquivo é 'activar_estilo'
// Véxase https://typst.app/docs/reference/styling
#show: activar_estilo.with(
    Titulo: "Momentum",
    portada: crear_portada(),
    indice: crear_indice()
)

//// 'include' o que fai é executar o código do arquivo que corresponda e
// móstrao como texto normal, en vez de importar funcións ou variables
#include("artigos/artigo_DECANATO.typ")
#include("artigos/artigo_CARATHEODORY.typ")
#include("artigos/artigo_ALMORZO.typ")
#include("artigos/artigo_SKYRMIONS.typ")
#include("artigos/artigo_ENTREVISTA.typ")
#include("artigos/artigo_IRMAS.typ")
#include("artigos/artigo_XEOCENTRISMO.typ")
