import Foundation
import RealmSwift

class AdministradorBaseDatos{
    
    static let instancia = AdministradorBaseDatos()
    
    func inicializar(){
        let realm = try! Realm()
        let usuariosCantidad = realm.objects(Usuario.self).count
        if usuariosCantidad < 1 {
            print("Llenado de BD")
            let datos = DatosIniciales()
            try! realm.write {
                realm.add(datos.usuario1)
                realm.add(datos.usuario2)
                realm.add(datos.usuario3)
                realm.add(datos.noticia1)
                realm.add(datos.noticia2)
                realm.add(datos.noticia3)
                realm.add(datos.noticia4)
                realm.add(datos.noticia5)
                realm.add(datos.noticia6)
                realm.add(datos.noticia7)
                realm.add(datos.convenio1)
                realm.add(datos.convenio2)
                realm.add(datos.convenio3)
                realm.add(datos.convenio4)
                realm.add(datos.convenio5)
                realm.add(datos.convenio6)
                realm.add(datos.convenio7)
                realm.add(datos.convenio8)
                realm.add(datos.propuesta1)
                realm.add(datos.propuesta2)
                realm.add(datos.propuesta3)
            }
        }
        print("Usuarios: \( realm.objects(Usuario.self).count)")
        print("Noticias: \( realm.objects(Noticia.self).count)")
        print("Convenios: \( realm.objects(Convenio.self).count)")
        print("Propuestas: \( realm.objects(Propuesta.self).count)")
    }
    
}
