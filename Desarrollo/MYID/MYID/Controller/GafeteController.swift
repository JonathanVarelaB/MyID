import UIKit
import SVProgressHUD

class GafeteController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    @IBOutlet weak var viewGafete: UIView!
    @IBOutlet weak var viewContacto: UIView!
    @IBOutlet weak var fotoGafete: UIImageView!
    @IBOutlet weak var menuBoton: UIBarButtonItem!
    @IBOutlet weak var nombreText: UILabel!
    @IBOutlet weak var puestoText: UILabel!
    @IBOutlet weak var identificacionText: UILabel!
    @IBOutlet weak var telefonoText: UILabel!
    @IBOutlet weak var correoText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(GafeteController.cargarUsuario),name: NSNotification.Name(rawValue: "modalIsDimissed"),object: nil)
        self.eventoFoto()
        self.establecerDiseno()
        self.funcionamientoMenu()
        self.revealViewController().rearViewRevealOverdraw = 0
        self.cargarUsuario()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func establecerDiseno(){
        self.viewGafete.layer.borderWidth = 2
        self.viewGafete.layer.borderColor = UIColor(red: 51.0/255, green: 102.0/255, blue: 153.0/255, alpha: 1.0).cgColor
        self.fotoGafete.layer.masksToBounds = true
        self.viewContacto.clipsToBounds = false
        self.viewContacto.layer.cornerRadius = 40
        self.viewContacto.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    func funcionamientoMenu(){
        if self.revealViewController() != nil {
            self.menuBoton.target = self.revealViewController()
            self.menuBoton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    @objc func cargarUsuario(){
        SVProgressHUD.show(withStatus: "Cargando")
        AdministradorBaseDatos.instancia.cargarUsuario(identificacion: AdministradorBaseDatos.idUsuarioActual, onSuccess: { array in
            DispatchQueue.main.async {
                if array.count > 0{
                    let usuario = array[0] as! Usuario
                    self.nombreText.text = usuario.nombre
                    self.puestoText.text = usuario.puesto
                    self.identificacionText.text = usuario.identificacion
                    self.telefonoText.text = usuario.telefono
                    self.correoText.text = usuario.correo
                    self.fotoGafete.image = UIImage(named: usuario.foto)
                }
                SVProgressHUD.dismiss()
            }
        })
    }
    
    @IBAction func editarGafete(_ sender: UIBarButtonItem) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "EditarGafeteController") as! EditarGafeteController
        vc.correo = self.correoText.text!
        vc.nom = self.nombreText.text!
        vc.tel = self.telefonoText.text!
        self.present(vc, animated: true, completion: nil)
    }
    
    func eventoFoto(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(GafeteController.showActionSheet))
        self.fotoGafete.isUserInteractionEnabled = true
        self.fotoGafete.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func showActionSheet() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camara", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.camara()
        }))
        actionSheet.addAction(UIAlertAction(title: "Galería", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.galeria()
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func camara(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = .camera
            self.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    func galeria(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = .photoLibrary
            self.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //self.fotoGafete.image = image
            self.guardarNuevaFoto(image: image)
        }
        self.dismiss(animated: true, completion: nil)
        //self.guardarNuevaFoto(image: self.fotoGafete.image!)
    }
    
    func guardarNuevaFoto(image: UIImage){
        print("Guardando foto")
        SVProgressHUD.show(withStatus: "Cargando")
        AdministradorBaseDatos.instancia.editarFotoUsuario(identificacion: AdministradorBaseDatos.idUsuarioActual, foto: image,
            onSuccess: { respuesta in
                DispatchQueue.main.async {
                    if respuesta {
                        self.fotoGafete.image = image
                        SVProgressHUD.dismiss()
                    }
                    else{
                        SVProgressHUD.dismiss()
                        self.alerta(titulo: "Gafete", subtitulo: "Hubo un error, intente de nuevo.", boton: "Aceptar")
                    }
                }
        })
    }
    
}
