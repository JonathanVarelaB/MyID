
import UIKit

extension UIView {
    func underlined(){
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor(red: 51.0/255, green: 102.0/255, blue: 153.0/255, alpha: 1.0).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func alerta(titulo: String, subtitulo: String, boton: String){
        let alert = UIAlertController(title: titulo, message: subtitulo, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: boton, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func validacionTextField(textField: UITextField!, maxLength: Int) {
        if textField.text!.count > 0 {
            if (textField.text!.count > maxLength) {
                textField.deleteBackward()
            }
            else{
                let caracter = String((textField.text?.last)!)
                let regex = try! NSRegularExpression(pattern: ".*[^A-Za-z0-9].*", options: [])
                if regex.matches(in: caracter, options: [], range: NSRange(location: 0, length: 1)).count > 0 {
                    textField.deleteBackward()
                }
            }
        }
    }
    
}

