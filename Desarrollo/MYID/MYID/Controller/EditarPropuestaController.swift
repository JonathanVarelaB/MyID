import UIKit

class EditarPropuestaController: UIViewController, UITextViewDelegate{

    @IBOutlet weak var descripcionText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descripcionText.delegate = self
        self.descripcionText.text = "Descripción"
        self.descripcionText.textColor = UIColor.lightGray
        self.descripcionText.underlined()
        self.descripcionText.delegate = self
        self.hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func cancelar(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor(red: 51.0/255, green: 102.0/255, blue: 153.0/255, alpha: 1.0)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Descripción"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.characters.count
        return numberOfChars < 80
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
