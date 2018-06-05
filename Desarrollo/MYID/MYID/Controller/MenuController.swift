import UIKit

class MenuController: UITableViewController {

    @IBOutlet weak var salirBoton: UIButton!
    @IBOutlet weak var olvidarSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.verificarEstadoUsuario()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func salirBoton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Salir", message: "¿Deseas salir de MyID?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.destructive, handler: { action in self.salir() }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func verificarEstadoUsuario(){
        if !AdministradorBaseDatos.recordarUsuario{
            self.olvidarSwitch.isOn = false
            self.olvidarSwitch.isEnabled = false
        }
        else{
            self.olvidarSwitch.isOn = true
        }
    }
    
    func salir(){
        AdministradorBaseDatos.instancia.olvidarUsuario(identificacion: AdministradorBaseDatos.idUsuarioActual, onSuccess: { respuesta in
            DispatchQueue.main.async {
                AdministradorBaseDatos.idUsuarioActual = ""
                let vc : UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "LoginScreen")
                self.present(vc, animated: true, completion: nil)
            }
        })
    }
    
    @IBAction func olvidarCredenciales(_ sender: UISwitch) {
        AdministradorBaseDatos.instancia.olvidarUsuario(identificacion: AdministradorBaseDatos.idUsuarioActual, onSuccess: { respuesta in
            DispatchQueue.main.async {
                if respuesta {
                    AdministradorBaseDatos.recordarUsuario = false
                    self.verificarEstadoUsuario()
                }
                else{
                    self.alerta(titulo: "Gafete", subtitulo: "Hubo un error, intente de nuevo.", boton: "Aceptar")
                }
            }
        })
    }
}
