import UIKit
import SVProgressHUD

class EditarPropuestaController: UIViewController, UITextViewDelegate{

    @IBOutlet weak var descripcionText: UITextView!
    var desc = ""
    var actividad: Int = 0
    var idPropuesta: Int = 0
    /* actividad
        0 -> agregar
        1 -> editar
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.establecerDiseno()
        self.descripcionText.text = self.desc
        self.descripcionText.delegate = self
        self.hideKeyboardWhenTappedAround()
        if self.desc == "" {
            self.establecerPlaceholder(texto: "Descripción", color: UIColor.lightGray)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func cancelar(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func validacionFormulario() -> String{
        if self.descripcionText.textColor == UIColor.lightGray {
            return "Datos incompletos"
        }
        else{
            if (self.descripcionText.text?.count)! < 5 {
                return "La propuesta debe de poseer 5 caracteres como mínimo"
            }
        }
        return ""
    }
    
    @IBAction func guardarPropuesta(_ sender: UIButton) {
        let mensaje : String = self.validacionFormulario()
        if mensaje != "" {
            self.alerta(titulo: "Propuesta", subtitulo: mensaje, boton: "Aceptar")
        }
        else{
            SVProgressHUD.show(withStatus: "Cargando")
            if self.actividad == 0 {
                AdministradorBaseDatos.instancia.agregarPropuesta(
                    propuesta: self.descripcionText.text, creador: AdministradorBaseDatos.idUsuarioActual, onSuccess: { respuesta in
                    DispatchQueue.main.async {
                        self.callbackGuardar(respuesta: respuesta)
                    }
                })
            }
            else{
                if self.actividad == 1 {
                    AdministradorBaseDatos.instancia.editarPropuesta(
                        idPropuesta: self.idPropuesta, descPropuesta: self.descripcionText.text, onSuccess: { respuesta in
                        DispatchQueue.main.async {
                            self.callbackGuardar(respuesta: respuesta)
                        }
                    })
                }
            }
        }
    }
    
    func callbackGuardar(respuesta: Bool){
        if respuesta {
            SVProgressHUD.dismiss()
            self.dismiss(animated: true, completion: {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "modalIsDimissed"), object: nil)
            })
        }
        else {
            SVProgressHUD.dismiss()
            self.alerta(titulo: "Propuesta", subtitulo: "Hubo un error, intente de nuevo.", boton: "Aceptar")
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            self.establecerPlaceholder(texto: "", color: UIColor(red: 51.0/255, green: 102.0/255, blue: 153.0/255, alpha: 1.0))
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text != "" {
            let caracter = String((textView.text?.last)!)
            let regex = try! NSRegularExpression(pattern: ".*[^A-Za-z0-9,.:()$%áéíóúÁÉÍÓÚ ].*", options: [])
            if regex.matches(in: caracter, options: [], range: NSRange(location: 0, length: 1)).count > 0 {
                textView.deleteBackward()
            }
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
        return numberOfChars < 90
    }
    
    func establecerPlaceholder(texto: String, color: UIColor){
        self.descripcionText.text = texto
        self.descripcionText.textColor = color
    }
    
    func establecerDiseno(){
        self.descripcionText.underlined()
    }
}
