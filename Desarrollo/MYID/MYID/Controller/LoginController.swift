import UIKit

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
    
    @IBAction func ingresar(_ sender: UIButton) {
        //print("\(self.identificacionText.text) \(self.claveText.text) \(self.recordarSwitch.isOn)")
    }
    
}
