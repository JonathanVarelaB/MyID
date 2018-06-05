import UIKit
import SVProgressHUD

class LoginController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var identificacionText: UITextField!
    @IBOutlet weak var claveText: UITextField!
    @IBOutlet weak var recordarSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.verificarUsuarioRecordado()
        self.establecerDiseno()
        self.eventosTeclado()
        self.identificacionText.delegate = self
        self.claveText.delegate = self
        self.hideKeyboardWhenTappedAround()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func establecerDiseno () {
        self.identificacionText.underlined()
        self.claveText.underlined()
    }
    
    func eventosTeclado(){
        NotificationCenter.default.addObserver(self, selector: #selector(LoginController.keyboardWillShow(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginController.keyboardWillHide(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        /*
        var keyboardHeight : CGFloat! = nil
        if let keyboardFrame: NSValue = sender.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            keyboardHeight = keyboardFrame.cgRectValue.height
        }
        self.view.frame.origin.y = (keyboardHeight * -1)
         */
        self.view.frame.origin.y = -150
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField{
        case identificacionText :
            self.claveText.becomeFirstResponder()
        default:
            self.view.endEditing(true)
        }
        return true
    }
    
    func validacionFormulario() -> String{
        
        if self.identificacionText.text == "" || self.claveText.text == "" {
            return "Datos incompletos"
        }
        else{
            if (self.identificacionText.text?.count)! < 8 {
                return "La identificación debe de poseer 8 dígitos como mínimo"
            }
            else{
                if (self.claveText.text?.count)! < 5 {
                    return "La contraseña debe de poseer 5 dígitos como mínimo"
                }
            }
        }
        return ""
    }
    
    @IBAction func cambioIdentificacion(_ sender: UITextField) {
        self.validacionTextField(textField: sender, maxLength: 10, conEspacio: false)
    }
    
    @IBAction func cambioClave(_ sender: UITextField) {
        self.validacionTextField(textField: sender, maxLength: 8, conEspacio: false)
    }
    
    @IBAction func ingresar(_ sender: UIButton) {
        let mensaje : String = self.validacionFormulario()
        if mensaje != "" {
            self.alerta(titulo: "Inicio de Sesión", subtitulo: mensaje, boton: "Aceptar")
        }
        else{
            SVProgressHUD.show(withStatus: "Cargando")
            AdministradorBaseDatos.instancia.verificarCredenciales(
                identificacion: self.identificacionText.text!, clave: self.claveText.text!, recordar: self.recordarSwitch.isOn
                , onSuccess: { respuesta in
                    DispatchQueue.main.async {
                        if respuesta {
                            AdministradorBaseDatos.idUsuarioActual = self.identificacionText.text!
                            AdministradorBaseDatos.recordarUsuario = self.recordarSwitch.isOn
                            let vc : UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "MenuSideScreen")
                            SVProgressHUD.dismiss()
                            self.present(vc, animated: true, completion: nil)
                        }
                        else{
                            SVProgressHUD.dismiss()
                            self.claveText.text = ""
                            self.alerta(titulo: "Inicio de Sesión", subtitulo: "Datos incorrectos, intente de nuevo", boton: "Aceptar")
                        }
                    }
            })
        }
    }
    
    func verificarUsuarioRecordado(){
        AdministradorBaseDatos.instancia.verificarUsuarioRecordado(onSuccess: { identificacion in
                DispatchQueue.main.async {
                    if identificacion != "" {
                        AdministradorBaseDatos.recordarUsuario = true
                        AdministradorBaseDatos.idUsuarioActual = identificacion
                        let vc : UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "MenuSideScreen")
                        self.present(vc, animated: true, completion: nil)
                    }
                }
        })
    }
    
}
