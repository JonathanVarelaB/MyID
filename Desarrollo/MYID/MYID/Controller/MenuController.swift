import UIKit

class MenuController: UITableViewController {

    @IBOutlet weak var salirBoton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    func salir(){
        AdministradorBaseDatos.instancia.olvidarUsuario(identificacion: AdministradorBaseDatos.idUsuarioActual, onSuccess: { respuesta in
            DispatchQueue.main.async {
                AdministradorBaseDatos.idUsuarioActual = ""
                let vc : UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "LoginScreen")
                self.present(vc, animated: true, completion: nil)
            }
        })
    }
    
}
