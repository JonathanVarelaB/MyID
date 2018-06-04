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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! ConvenioCell
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "MapaController") as! MapaController
        vc.latitud = currentCell.latitud
        vc.longitud = currentCell.longitud
        vc.lugarNombre = currentCell.lugarTexto.text!
        navigationController?.show(vc, sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.restaurantes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Convenio Cell", for: indexPath) as! ConvenioCell
        cell.descripcionTexto.text = self.restaurantes[indexPath.row].descripcion
        cell.lugarTexto.text = self.restaurantes[indexPath.row].lugar
        cell.tiempoTexto.text = self.restaurantes[indexPath.row].tiempo
        cell.longitud = Double(self.restaurantes[indexPath.row].longitud)!
        cell.latitud = Double(self.restaurantes[indexPath.row].latitud)!
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
