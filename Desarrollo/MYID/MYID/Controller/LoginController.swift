import UIKit
import SVProgressHUD

class LoginController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var identificacionText: UITextField!
    @IBOutlet weak var claveText: UITextField!
    @IBOutlet weak var recordarSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        self.validacionTextField(textField: sender, maxLength: 10)
    }
    
    @IBAction func cambioClave(_ sender: UITextField) {
        self.validacionTextField(textField: sender, maxLength: 8)
    }
    
    @IBAction func ingresar(_ sender: UIButton) {
        let mensaje : String = self.validacionFormulario()
        if mensaje != "" {
            self.alerta(titulo: "Inicio de Sesión", subtitulo: mensaje, boton: "Aceptar")
        }
        else{
            // consultar Usuario
            SVProgressHUD.show(withStatus: "Cargando")
            Timer.scheduledTimer(timeInterval: 0.5, target: BlockOperation(block: block), selector: #selector(Operation.main), userInfo: nil, repeats: false)
        }
    }
    
    func block(){
        let vc : UIViewController = storyboard!.instantiateViewController(withIdentifier: "MenuSideScreen")
        SVProgressHUD.dismiss()
        self.present(vc, animated: true, completion: nil)
    }
    
}
