import UIKit
import SVProgressHUD

class RestaurantesController: UITableViewController {
    
    var restaurantes: [Convenio] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cargarRestaurantes()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.restaurantes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Convenio Cell", for: indexPath) as! ConvenioCell
        
        //cell.labelCel.text = self.noticias[indexPath.row]
        //cell.imagenCell.image = UIImage(named: self.noticias[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 80.0;
    }

    func cargarRestaurantes(){
        print("Cargar Restaurantes")
        SVProgressHUD.show(withStatus: "Cargando")
        AdministradorBaseDatos.instancia.cargarConvenios(tipo: 1, onSuccess: { restaurantesArray in
            DispatchQueue.main.async {
                if restaurantesArray.count > 0{
                    self.restaurantes = restaurantesArray
                    self.tableView.reloadData()
                }
                SVProgressHUD.dismiss()
            }
        })
    }
    
}
