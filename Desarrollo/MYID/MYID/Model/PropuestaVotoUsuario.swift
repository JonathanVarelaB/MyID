import Foundation
import RealmSwift

class PropuestaVotoUsuario: Object{
    @objc dynamic var propuesta: Int = 0
    @objc dynamic var usuario: String = ""
    @objc dynamic var voto: Bool = true
}
