import Foundation
import RealmSwift

class PropuestaVotoUsuario: Object{
    @objc dynamic var propuesta: Int = 0
    @objc dynamic var usuario: String = ""
    @objc dynamic var voto: Int = 0
    /* Voto
        0 -> sin voto
        1 -> positivo
        2 -> negativo
    */
}
