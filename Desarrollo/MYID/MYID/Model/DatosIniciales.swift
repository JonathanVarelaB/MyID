import Foundation

class DatosIniciales{
    
    let usuario1 = Usuario()
    let usuario2 = Usuario()
    let usuario3 = Usuario()
    let noticia1 = Noticia()
    let noticia2 = Noticia()
    let noticia3 = Noticia()
    let noticia4 = Noticia()
    let noticia5 = Noticia()
    let noticia6 = Noticia()
    let noticia7 = Noticia()
    let convenio1 = Convenio()
    let convenio2 = Convenio()
    let convenio3 = Convenio()
    let convenio4 = Convenio()
    let convenio5 = Convenio()
    let convenio6 = Convenio()
    let convenio7 = Convenio()
    let convenio8 = Convenio()
    let propuesta1 = Propuesta()
    let propuesta2 = Propuesta()
    let propuesta3 = Propuesta()
    
    init(){
        // USUARIOS
        usuario1.identificacion = "115670126"
        usuario1.nombre = "Jonathan Varela Barrantes"
        usuario1.puesto = "Desarrollador"
        usuario1.correo = "jvarela@tecnosys.net"
        usuario1.clave = "670126"
        usuario1.telefono = "70889697"
        usuario2.identificacion = "123456789"
        usuario2.nombre = "Rafael Castro Jiménez"
        usuario2.puesto = "Contador"
        usuario2.correo = "rcastro@tecnosys.net"
        usuario2.clave = "456789"
        usuario2.telefono = "83473973"
        usuario3.identificacion = "987654321"
        usuario3.nombre = "Andrea Villalobos Víquez"
        usuario3.puesto = "Diseñadora"
        usuario3.correo = "avillalobos@tecnosys.net"
        usuario3.clave = "654321"
        usuario3.telefono = "84823498"
        // NOTICIAS
        noticia1.identificador = 1
        noticia1.titular = "Expansión contempla dar respaldo en TI, adicional al de finanzas y administración desde Costa Rica"
        noticia1.enlace = "https://www.larepublica.net/noticia/director-de-swarovski-expansion-contempla-dar-respaldo-en-ti-adicional-al-de-finanzas-y-administracion-desde-costa-rica"
        noticia1.fecha = "28 mayo 2018"
        noticia2.identificador = 2
        noticia2.titular = "Nueva ley de empleo público es necesaria para reducir déficit fiscal"
        noticia2.enlace = "https://www.larepublica.net/noticia/nueva-ley-de-empleo-publico-es-necesaria-para-reducir-deficit-fiscal"
        noticia2.fecha = " 15 mayo 2018"
        noticia3.identificador = 3
        noticia3.titular = "¿Cómo es que las empresas generan innovación?"
        noticia3.enlace = "https://www.larepublica.net/noticia/como-es-que-las-empresas-generan-innovacion-parte-1"
        noticia3.fecha = "3 mayo 2018"
        noticia4.identificador = 4
        noticia4.titular = "Mundial financiero en favor del consumidor"
        noticia4.enlace = "https://www.larepublica.net/noticia/mundial-financiero-en-favor-del-consumidor"
        noticia4.fecha = "20 abril 2018"
        noticia5.identificador = 5
        noticia5.titular = "Empresarios se asocian para impulsar el 'facility management'"
        noticia5.enlace = "https://www.larepublica.net/noticia/empresarios-se-asocian-para-impulsar-el-facility-management"
        noticia5.fecha = "13 abril 2018"
        noticia6.identificador = 6
        noticia6.titular = "Emprendedor hace de la nutrición consciente un negocio exitoso"
        noticia6.enlace = "https://www.larepublica.net/noticia/emprendedor-hace-de-la-nutricion-consciente-un-negocio-exitoso"
        noticia6.fecha = "20 marzo 2018"
        noticia7.identificador = 7
        noticia7.titular = "Nuevas plantas geotérmicas crearán oportunidades de negocios"
        noticia7.enlace = "https://www.larepublica.net/noticia/nuevas-plantas-geotermicas-crearan-oportunidades-de-negocios"
        noticia7.fecha = "5 marzo 2018"
        // CONVENIOS
        convenio1.identificador = 0
        convenio1.lugar = "Pops"
        convenio1.descripcion = "30% de descuento en Milk Shakes"
        convenio1.tiempo = "Miércoles"
        convenio1.tipo = 1
        convenio1.latitud = "9.952612"
        convenio1.longitud = "-84.078481"
        convenio2.identificador = 1
        convenio2.lugar = "Pizza Hut"
        convenio2.descripcion = "Refresco gratis por la compra de cualquier pizza"
        convenio2.tiempo = "Lunes a Jueves"
        convenio2.tipo = 1
        convenio2.latitud = "9.958741"
        convenio2.longitud = "-84.078223"
        convenio3.identificador = 2
        convenio3.lugar = "Subway"
        convenio3.descripcion = "20% de descuento en compras mayores a 5.000 colones"
        convenio3.tiempo = "Martes y Jueves"
        convenio3.tipo = 1
        convenio3.latitud = "9.971718"
        convenio3.longitud = "-84.088552"
        convenio4.identificador = 3
        convenio4.lugar = "Manpukusushi"
        convenio4.descripcion = "3 x 2 en rollos seleccionados"
        convenio4.tiempo = "Todos los días"
        convenio4.tipo = 1
        convenio4.latitud = "9.984427"
        convenio4.longitud = "-84.082408"
        convenio5.identificador = 4
        convenio5.lugar = "iShop"
        convenio5.descripcion = "Revisión de equipo gratuita"
        convenio5.tiempo = "Todos los días"
        convenio5.tipo = 2
        convenio5.latitud = "9.988409"
        convenio5.longitud = "-84.111026"
        convenio6.identificador = 5
        convenio6.lugar = "Adidas"
        convenio6.descripcion = "10% de descuento en ropa deportiva"
        convenio6.tiempo = "Lunes a Viernes"
        convenio6.tipo = 2
        convenio6.latitud = "9.944079"
        convenio6.longitud = "-84.149683"
        convenio7.identificador = 6
        convenio7.lugar = "Intensa"
        convenio7.descripcion = "25% de descuento en todos los cursos"
        convenio7.tiempo = "Todos los días"
        convenio7.tipo = 3
        convenio7.latitud = "9.933283"
        convenio7.longitud = "-84.063783"
        convenio8.identificador = 7
        convenio8.lugar = "Skorpio"
        convenio8.descripcion = "Matrícula gratis"
        convenio8.tiempo = "Todos los días"
        convenio8.tipo = 3
        convenio8.latitud = "10.000021"
        convenio8.longitud = "-84.104086"
        // PROPUESTAS
        propuesta1.identificador = 0
        propuesta1.creador = "115670126"
        propuesta1.descripcion = "Adquirir nuevas sillas para mejorar comodidad del personal"
        propuesta2.identificador = 1
        propuesta2.creador = "123456789"
        propuesta2.descripcion = "Realizar actividades grupales extralaborales"
        propuesta3.identificador = 2
        propuesta3.creador = "987654321"
        propuesta3.descripcion = "Disminuir el uso del papel en la empresa"
    }
}
