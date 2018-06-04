import UIKit
import SVProgressHUD

class EditarGafeteController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nombreText: UITextField!
    @IBOutlet weak var telefonoText: UITextField!
    @IBOutlet weak var correoText: UITextField!
    var nom = ""
    var tel = ""
    var correo = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.establecerDiseno()
        self.hideKeyboardWhenTappedAround()
        self.nombreText.text = nom
        self.telefonoText.text = tel
        self.correoText.text = correo
        self.nombreText.delegate = self
        self.telefonoText.delegate = self
        self.correoText.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField{
        case nombreText :
            self.telefonoText.becomeFirstResponder()
        case telefonoText :
            self.correoText.becomeFirstResponder()
        default:
            self.view.endEditing(true)
        }
        return true
    }
    
    @IBAction func cambioNombre(_ sender: UITextField) {
        self.validacionTextField(textField: sender, maxLength: 30, conEspacio: true)
    }
    
    @IBAction func cambioTelefono(_ sender: UITextField) {
        self.validacionTextField(textField: sender, maxLength: 8, conEspacio: false)
    }
    
    @IBAction func cambioCorreo(_ sender: UITextField) {
        self.validacionTextField(textField: sender, maxLength: 30, conEspacio: false)
    }
    
    func establecerDiseno(){
        self.nombreText.underlined()
        self.telefonoText.underlined()
        self.correoText.underlined()
    }
    
    func validacionFormulario() -> String{
        if self.nombreText.text! == "" || self.correoText.text! == "" || self.telefonoText.text! == "" {
            return "Datos incompletos"
        }
        else{
            if (self.nombreText.text?.count)! < 5 {
                return "El nombre debe de poseer 5 caracteres como mínimo"
            }
            else{
                if (self.telefonoText.text?.count)! < 8 {
                    return "El teléfono debe de poseer 8 dígitos"
                }
                else{
                    if (self.correoText.text?.count)! < 6 {
                        return "El correo debe de poseer 5 caracteres como mínimo"
                    }
                }
            }
        }
        return ""
    }
    
    @IBAction func cancelarBoton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func guardarBoton(_ sender: UIButton) {
        let mensaje : String = self.validacionFormulario()
        if mensaje != "" {
            self.alerta(titulo: "Gafete", subtitulo: mensaje, boton: "Aceptar")
        }
        else{
            SVProgressHUD.show(withStatus: "Cargando")
            AdministradorBaseDatos.instancia.editarUsuario(
                identificacion: AdministradorBaseDatos.idUsuarioActual, nombre: self.nombreText.text!,
                telefono: self.telefonoText.text!, correo: self.correoText.text!, onSuccess: { respuesta in
                    DispatchQueue.main.async {
                        if respuesta {
                            SVProgressHUD.dismiss()
                            self.dismiss(animated: true, completion: {
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "modalIsDimissed"), object: nil)
                            })
                        }
                        else{
                            SVProgressHUD.dismiss()
                            self.alerta(titulo: "Gafete", subtitulo: "Hubo un error, intente de nuevo.", boton: "Aceptar")
                        }
                    }
            })
            
            
        }
    }
    
}
