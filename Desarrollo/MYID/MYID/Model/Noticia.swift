import Foundation
import RealmSwift

class Noticia: Object {
    @objc dynamic var identificador: Int = 0
    @objc dynamic var titular: String = ""
    @objc dynamic var fecha: String = ""
    @objc dynamic var enlace: String = ""
}
