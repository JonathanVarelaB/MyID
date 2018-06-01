import Foundation
import RealmSwift

class Propuesta: Object{
    @objc dynamic var identificador: Int = 0
    @objc dynamic var descripcion: String = ""
    @objc dynamic var creador: String = ""
}
