// 'import' carga todas as funcións definidas con '#let' no arquivo estilo.typ
#import("estilo.typ"): *

#let SobreMomentum = [
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

#let Participantes = [
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


// Unha das funcións cargadas de dito arquivo é 'activar_estilo'
// Véxase https://typst.app/docs/reference/styling
#show: activar_estilo.with(
    Numero            : "001",
    Data              : datetime.today(),
    CorResalte        : "ffff00",
    CorTextoEnResalte : "000000",
    Participantes     : ("Fulano", "Mengano"),
    Despedida         : "Adeus! ",
    Agradecementos    : "Grazas! ",
    portada           : crear_portada("/imaxes/pedra.jpg", "comentario"),
    indice            : crear_indice(SobreMomentum,Participantes),
    contraportada     : crear_contraportada()
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
