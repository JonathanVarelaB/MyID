import Foundation
import RealmSwift

class AdministradorBaseDatos{
    
    let realm = try! Realm()
    static let instancia = AdministradorBaseDatos()
    static var idUsuarioActual = ""
    static var recordarUsuario = false
    
    func inicializar(){
        let usuariosCantidad = self.realm.objects(Usuario.self).count
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
                //realm.add(datos.propuesta1)
                //realm.add(datos.propuesta2)
                //realm.add(datos.propuesta3)
            }
        }
        print("Usuarios: \( realm.objects(Usuario.self).count)")
        print("Noticias: \( realm.objects(Noticia.self).count)")
        print("Convenios: \( realm.objects(Convenio.self).count)")
        print("Propuestas: \( realm.objects(Propuesta.self).count)")
    }
    
    func verificarCredenciales(identificacion: String, clave: String, recordar: Bool, onSuccess: @escaping(Bool) -> Void){
        Timer.scheduledTimer(withTimeInterval: TimeInterval(1), repeats: false, block: { (Timer)  -> Void in
            let usuario = self.realm.objects(Usuario.self).filter("identificacion == '" + identificacion + "' AND clave == '" + clave + "'")
            if usuario.count > 0 {
                if recordar {
                    let usuarios = self.realm.objects(Usuario.self)
                    try! self.realm.write {
                        usuarios.map{ $0.recordar = false }
                    }
                }
                try! self.realm.write{
                    usuario[0].recordar = recordar
                }
                onSuccess(true)
            }
            else{
                onSuccess(false)
            }
        })
    }
    
    func verificarUsuarioRecordado(onSuccess: @escaping(String) -> Void){
        var identificacion = ""
        let usuario = self.realm.objects(Usuario.self).filter("recordar == true")
        if usuario.count > 0 {
            identificacion = usuario[0].identificacion
        }
        onSuccess(identificacion)
    }
    
    func olvidarUsuario(identificacion: String, onSuccess: @escaping(Bool) -> Void){
        let usuario = self.realm.objects(Usuario.self).filter("identificacion == '" + identificacion + "'")
        if usuario.count > 0 {
            try! self.realm.write{
                usuario[0].recordar = false
            }
            onSuccess(true)
        }
        else{
            onSuccess(false)
        }
    }
    
    func cargarUsuario(identificacion: String, onSuccess: @escaping([Any]) -> Void){
        let usuario = self.realm.objects(Usuario.self).filter("identificacion == '" + identificacion + "'")
        if usuario.count > 0 {
            onSuccess([usuario[0]])
        }
        else{
            onSuccess([])
        }
    }
    
    func cargarNoticias(onSuccess: @escaping([Noticia]) -> Void){
        Timer.scheduledTimer(withTimeInterval: TimeInterval(1), repeats: false, block: { (Timer)  -> Void in
            let noticias = self.realm.objects(Noticia.self)
            onSuccess(Array(noticias))
        })
    }
    
    func cargarConvenios(tipo: Int, onSuccess: @escaping([Convenio]) -> Void){
        Timer.scheduledTimer(withTimeInterval: TimeInterval(1), repeats: false, block: { (Timer)  -> Void in
            let convenios = self.realm.objects(Convenio.self).filter("tipo == \(tipo)")
            onSuccess(Array(convenios))
        })
    }
    
    func cargarPropuestas(onSuccess: @escaping([Propuesta]) -> Void){
        Timer.scheduledTimer(withTimeInterval: TimeInterval(0.5), repeats: false, block: { (Timer)  -> Void in
            let propuestas = self.realm.objects(Propuesta.self).sorted(byKeyPath: "identificador", ascending: false)
            onSuccess(Array(propuestas))
        })
    }
    
    func editarUsuario(identificacion: String, nombre: String, telefono: String, correo: String, onSuccess: @escaping(Bool) -> Void){
        Timer.scheduledTimer(withTimeInterval: TimeInterval(1), repeats: false, block: { (Timer)  -> Void in
            let usuario = self.realm.objects(Usuario.self).filter("identificacion == '" + identificacion + "'")
            if usuario.count > 0 {
                try! self.realm.write{
                    usuario[0].nombre = nombre
                    usuario[0].telefono = telefono
                    usuario[0].correo = correo
                }
                onSuccess(true)
            }
            else{
                onSuccess(false)
            }
        })
    }
    
    func editarFotoUsuario(identificacion: String, foto: UIImage, onSuccess: @escaping(Bool) -> Void){
        Timer.scheduledTimer(withTimeInterval: TimeInterval(1), repeats: false, block: { (Timer)  -> Void in
            let usuario = self.realm.objects(Usuario.self).filter("identificacion == '" + identificacion + "'")
            if usuario.count > 0 {
                if AdministradorImagenes.instancia.guardarImagen(image: foto, nombre: identificacion){
                    try! self.realm.write{
                        usuario[0].foto = identificacion
                    }
                    onSuccess(true)
                }
                else{
                    onSuccess(false)
                }
            }
            else{
                onSuccess(false)
            }
        })
    }
    
    func obtenerNombreUsuario(identificacion: String, onSuccess: @escaping(String) -> Void){
        let usuario = self.realm.objects(Usuario.self).filter("identificacion == '" + identificacion + "'")
        if usuario.count > 0 {
            onSuccess(usuario[0].nombre)
        }
        else{
            onSuccess("")
        }
    }
    
    func agregarPropuesta(propuesta: String, creador: String, onSuccess: @escaping(Bool) -> Void){
        Timer.scheduledTimer(withTimeInterval: TimeInterval(1), repeats: false, block: { (Timer)  -> Void in
            let nuevaPropuesta = Propuesta()
            nuevaPropuesta.creador = creador
            nuevaPropuesta.descripcion = propuesta
            nuevaPropuesta.identificador = Int(Date().timeIntervalSince1970 * 1000.0)
            try! self.realm.write {
                self.realm.add(nuevaPropuesta)
            }
            onSuccess(true)
        })
    }
    
    func editarPropuesta(idPropuesta: Int, descPropuesta: String, onSuccess: @escaping(Bool) -> Void){
        Timer.scheduledTimer(withTimeInterval: TimeInterval(1), repeats: false, block: { (Timer)  -> Void in
            let propuesta = self.realm.objects(Propuesta.self).filter("identificador == \(idPropuesta)")
            if propuesta.count > 0 {
                try! self.realm.write{
                    propuesta[0].descripcion = descPropuesta
                }
                onSuccess(true)
            }
            else{
                onSuccess(false)
            }
        })
    }
    
    func eliminarPropuesta(idPropuesta: Int, onSuccess: @escaping(Bool) -> Void) {
        Timer.scheduledTimer(withTimeInterval: TimeInterval(1), repeats: false, block: { (Timer)  -> Void in
            let propuesta = self.realm.objects(Propuesta.self).filter("identificador == \(idPropuesta)")
            if propuesta.count > 0 {
                try! self.realm.write{
                    self.realm.delete(propuesta)
                }
                onSuccess(true)
            }
            else{
                onSuccess(false)
            }
        })
    }
    
    func obtenerVotoPropuestaUsuario(idPropuesta: Int, idUsuario: String, onSuccess: @escaping(Int) -> Void) {
        let votoPropUsua = self.realm.objects(PropuestaVotoUsuario.self).filter("propuesta == \(idPropuesta) AND usuario == '" + idUsuario + "'")
        if votoPropUsua.count > 0 {
            onSuccess(votoPropUsua[0].voto)
        }
        else{
            onSuccess(0)
        }
    }
    
    func votarPropuesta(idPropuesta: Int, idUsuario: String, voto: Int, onSuccess: @escaping(Bool) -> Void) {
        let votoPropUsua = self.realm.objects(PropuestaVotoUsuario.self).filter("propuesta == \(idPropuesta) AND usuario == '" + idUsuario + "'")
        if votoPropUsua.count > 0 {
            switch votoPropUsua[0].voto {
                case 1:
                    if voto == 1 {
                        self.votar(objeto: votoPropUsua[0], voto: 0)
                    }
                    else{
                        if voto == 2 {
                            self.votar(objeto: votoPropUsua[0], voto: 2)
                        }
                    }
                case 2:
                    if voto == 2 {
                        self.votar(objeto: votoPropUsua[0], voto: 0)
                    }
                    else{
                        if voto == 1 {
                            self.votar(objeto: votoPropUsua[0], voto: 1)
                        }
                    }
                default:
                    self.votar(objeto: votoPropUsua[0], voto: voto)
            }
        }
        else{
            let votoPU = PropuestaVotoUsuario()
            votoPU.propuesta = idPropuesta
            votoPU.usuario = idUsuario
            votoPU.voto = voto
            try! self.realm.write {
                self.realm.add(votoPU)
            }
        }
        onSuccess(true)
    }
    
    func votar(objeto: PropuestaVotoUsuario, voto: Int){
        try! self.realm.write {
            objeto.voto = voto
        }
    }
}
