import UIKit

class EditarPropuestaController: UIViewController, UITextViewDelegate{

    @IBOutlet weak var descripcionText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.establecerDiseno()
        self.descripcionText.delegate = self
        self.hideKeyboardWhenTappedAround()
        self.establecerPlaceholder(texto: "Descripción", color: UIColor.lightGray)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func cancelar(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            self.establecerPlaceholder(texto: "", color: UIColor(red: 51.0/255, green: 102.0/255, blue: 153.0/255, alpha: 1.0))
            //textView.text = nil
            //textView.textColor = UIColor(red: 51.0/255, green: 102.0/255, blue: 153.0/255, alpha: 1.0)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            self.establecerPlaceholder(texto: "Descripción", color: UIColor.lightGray)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        return numberOfChars < 80
    }
    
    func establecerPlaceholder(texto: String, color: UIColor){
        self.descripcionText.text = texto
        self.descripcionText.textColor = color
    }
    
    func establecerDiseno(){
        self.descripcionText.underlined()
    }
}
