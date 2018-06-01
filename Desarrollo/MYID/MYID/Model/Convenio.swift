import Foundation
import RealmSwift

class Convenio: Object{
    @objc dynamic var identificador: Int = 0
    @objc dynamic var lugar: String = ""
    @objc dynamic var descripcion: String = ""
    @objc dynamic var tiempo: String = ""
    @objc dynamic var tipo: Int = 0
    @objc dynamic var latitud: String = ""
    @objc dynamic var longitud: String = ""
}
/*
    Tipo:
        1 -> Restaurantes
        2 -> Tiendas
        3 -> Otros
 */
