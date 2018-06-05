import UIKit
import SVProgressHUD

class PropuestaController: UITableViewController {
    
    @IBOutlet weak var menuBoton: UIBarButtonItem!
    var propuestas: [Propuesta] = []
    var disagreeRojo: UIColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1.0)
    var agreeVerde: UIColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1.0)
    var disagreeImage: UIImage? = nil
    var agreeImage: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        cell.identificador = self.propuestas[indexPath.row].identificador
        cell.descripcionText.text = self.propuestas[indexPath.row].descripcion
        let autorId = self.propuestas[indexPath.row].creador
        if autorId == AdministradorBaseDatos.idUsuarioActual {
            cell.editarBoton.isHidden = false
            cell.eliminarBoton.isHidden = false
        }
        cell.editarBoton.tag = indexPath.row
        cell.eliminarBoton.tag = indexPath.row
        AdministradorBaseDatos.instancia.obtenerNombreUsuario(identificacion: autorId,onSuccess: { nombreUsuario in
            DispatchQueue.main.async {
                if nombreUsuario != "" {
                    cell.autorText.text = nombreUsuario
                }
            }
        })
        /*
        cell.disagreeBoton.setImage(disagreeImage, for: .normal)
        cell.disagreeBoton.tintColor = disagreeRojo
        cell.agreeBoton.setImage(agreeImage, for: .normal)
        cell.agreeBoton.tintColor = agreeVerde
        */
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 120.0;
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
        alert.addAction(UIAlertAction(title: "Eliminar", style: UIAlertActionStyle.destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func cargarPropuestas(){
        print("Cargar Propuestas")
        SVProgressHUD.show(withStatus: "Cargando")
        AdministradorBaseDatos.instancia.cargarPropuestas(onSuccess: { propuestasArray in
            DispatchQueue.main.async {
                if propuestasArray.count > 0{
                    self.propuestas = propuestasArray
                    self.tableView.reloadData()
                }
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
