import UIKit

class PropuestaController: UITableViewController {
    
    @IBOutlet weak var menuBoton: UIBarButtonItem!
    var propuestas = ["propuesta1", "propuesta2", "propuesta3"]
    var disagreeRojo : UIColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1.0)
    var agreeVerde : UIColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1.0)
    var disagreeImage : UIImage? = nil
    var agreeImage : UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        //cell.labelCel.text = self.noticias[indexPath.row]
        //cell.imagenCell.image = UIImage(named: self.noticias[indexPath.row])
        // asignar ID a alguna propiedad del boton para poder votar
        
        cell.disagreeBoton.setImage(disagreeImage, for: .normal)
        cell.disagreeBoton.tintColor = disagreeRojo
        cell.agreeBoton.setImage(agreeImage, for: .normal)
        cell.agreeBoton.tintColor = agreeVerde
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
    
}
