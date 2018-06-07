import UIKit
import SVProgressHUD

class PropuestaController: UITableViewController {
    
    @IBOutlet weak var menuBoton: UIBarButtonItem!
    var propuestas: [Propuesta] = []
    var disagreeRojo: UIColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1.0)
    var agreeVerde: UIColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1.0)
    var azulOscuro: UIColor = UIColor(red: 19.0/255, green: 41.0/255, blue: 59.0/255, alpha: 1.0)
    var disagreeImage: UIImage? = nil
    var agreeImage: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(PropuestaController.cargarPropuestas),name: NSNotification.Name(rawValue: "modalIsDimissed"),object: nil)
        self.cargarPropuestas()
        self.funcionamientoMenu()
        disagreeImage = UIImage(named: "disagree")?.withRenderingMode(.alwaysTemplate)
        agreeImage = UIImage(named: "agree")?.withRenderingMode(.alwaysTemplate)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.propuestas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Propuesta Cell", for: indexPath) as! PropuestaCell
        let autorId = self.propuestas[indexPath.row].creador
        cell.identificador = self.propuestas[indexPath.row].identificador
        cell.descripcionText.text = self.propuestas[indexPath.row].descripcion
        cell.editarBoton.tag = indexPath.row
        cell.eliminarBoton.tag = indexPath.row
        cell.agreeBoton.tag = indexPath.row
        cell.disagreeBoton.tag = indexPath.row
        cell.disagreeBoton.setImage(self.disagreeImage, for: .normal)
        cell.agreeBoton.setImage(self.agreeImage, for: .normal)
        cell.disagreeBoton.tintColor = self.azulOscuro
        cell.agreeBoton.tintColor = self.azulOscuro
        cell.editarBoton.isHidden = true
        cell.eliminarBoton.isHidden = true
        if autorId == AdministradorBaseDatos.idUsuarioActual {
            cell.editarBoton.isHidden = false
            cell.eliminarBoton.isHidden = false
        }
        AdministradorBaseDatos.instancia.obtenerNombreUsuario(identificacion: autorId,onSuccess: { nombreUsuario in
            DispatchQueue.main.async {
                if nombreUsuario != "" {
                    cell.autorText.text = nombreUsuario
                }
            }
        })
        AdministradorBaseDatos.instancia.obtenerVotoPropuestaUsuario(
            idPropuesta: cell.identificador, idUsuario: AdministradorBaseDatos.idUsuarioActual, onSuccess: { voto in
            DispatchQueue.main.async {
                switch voto {
                    case 1:
                        cell.agreeBoton.tintColor = self.agreeVerde
                        cell.disagreeBoton.tintColor = self.azulOscuro
                    case 2:
                        cell.disagreeBoton.tintColor = self.disagreeRojo
                        cell.agreeBoton.tintColor = self.azulOscuro
                    default:
                        cell.disagreeBoton.tintColor = self.azulOscuro
                        cell.agreeBoton.tintColor = self.azulOscuro
                }
            }
        })
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 120.0;
    }
    
    @IBAction func votarPositivo(_ sender: UIButton) {
        self.votar(tag: sender.tag, voto: 1)
    }
    
    @IBAction func votarNegativo(_ sender: UIButton) {
       self.votar(tag: sender.tag, voto: 2)
    }
    
    func votar(tag: Int, voto: Int){
        let indexpath = IndexPath(row: tag, section: 0)
        let currentCell = tableView.cellForRow(at: indexpath) as! PropuestaCell
        AdministradorBaseDatos.instancia.votarPropuesta(
            idPropuesta: currentCell.identificador, idUsuario: AdministradorBaseDatos.idUsuarioActual, voto: voto, onSuccess: { respuesta in
                DispatchQueue.main.async {
                    if respuesta {
                        self.cargarPropuestas()
                    }
                }
        })
    }
    
    func funcionamientoMenu(){
        if self.revealViewController() != nil {
            self.menuBoton.target = self.revealViewController()
            self.menuBoton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    @IBAction func eliminarPropuesta(_ sender: UIButton) {
        let alert = UIAlertController(title: "Eliminar", message: "¿Desea eliminar la propuesta?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Eliminar", style: UIAlertActionStyle.destructive, handler: { (alert:UIAlertAction!) -> Void in self.borrarPropuesta(sender: sender) }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func borrarPropuesta(sender: UIButton){
        SVProgressHUD.setStatus("Cargando")
        let indexpath = IndexPath(row: sender.tag, section: 0)
        let currentCell = tableView.cellForRow(at: indexpath) as! PropuestaCell
        AdministradorBaseDatos.instancia.eliminarPropuesta(idPropuesta: currentCell.identificador, onSuccess: { respuesta in
                DispatchQueue.main.async {
                    if respuesta {
                        SVProgressHUD.dismiss()
                        self.cargarPropuestas()
                    }
                    else {
                        SVProgressHUD.dismiss()
                        self.alerta(titulo: "Propuesta", subtitulo: "Hubo un error, intente de nuevo.", boton: "Aceptar")
                    }
                }
        })
    }
    
    @objc func cargarPropuestas(){
        print("Cargar Propuestas")
        SVProgressHUD.show(withStatus: "Cargando")
        AdministradorBaseDatos.instancia.cargarPropuestas(onSuccess: { propuestasArray in
            DispatchQueue.main.async {
                self.propuestas = propuestasArray
                self.tableView.reloadData()
                SVProgressHUD.dismiss()
            }
        })
    }
    
    @IBAction func agregarPropuesta(_ sender: UIBarButtonItem) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "EditarPropuestaController") as! EditarPropuestaController
        vc.actividad = 0
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func editarPropuesta(_ sender: UIButton) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "EditarPropuestaController") as! EditarPropuestaController
        let indexpath = IndexPath(row: sender.tag, section: 0)
        let currentCell = tableView.cellForRow(at: indexpath) as! PropuestaCell
        vc.actividad = 1
        vc.desc = currentCell.descripcionText.text!
        vc.idPropuesta = currentCell.identificador
        self.present(vc, animated: true, completion: nil)
    }
    
}
