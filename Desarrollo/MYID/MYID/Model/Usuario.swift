import Foundation
import RealmSwift

class Usuario: Object{
    @objc dynamic var identificacion: String = ""
    @objc dynamic var nombre: String = ""
    @objc dynamic var puesto: String = ""
    @objc dynamic var foto: String = "userDefault"
    @objc dynamic var telefono: String = ""
    @objc dynamic var correo: String = ""
    @objc dynamic var clave: String = ""
    @objc dynamic var recordar: Bool = false
}
