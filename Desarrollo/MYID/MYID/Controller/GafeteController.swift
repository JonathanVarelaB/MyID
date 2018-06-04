import UIKit
import SVProgressHUD

class GafeteController: UIViewController {
    
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
 
    func cargarUsuario(){
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
    
}
