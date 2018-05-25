import UIKit

class EditarGafeteController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nombreText: UITextField!
    @IBOutlet weak var telefonoText: UITextField!
    @IBOutlet weak var correoText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.establecerDiseno()
        self.hideKeyboardWhenTappedAround()
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
    
    func establecerDiseno(){
        self.nombreText.underlined()
        self.telefonoText.underlined()
        self.correoText.underlined()
    }
    
    @IBAction func cancelarBoton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
