
import UIKit
import SVProgressHUD

class TiendasController: UITableViewController {
    
    var tiendas: [Convenio] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cargarTiendas()
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
        return self.tiendas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Convenio Cell", for: indexPath) as! ConvenioCell
        cell.descripcionTexto.text = self.tiendas[indexPath.row].descripcion
        cell.lugarTexto.text = self.tiendas[indexPath.row].lugar
        cell.tiempoTexto.text = self.tiendas[indexPath.row].tiempo
        cell.longitud = Double(self.tiendas[indexPath.row].longitud)!
        cell.latitud = Double(self.tiendas[indexPath.row].latitud)!
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 80.0;
    }
    
    func cargarTiendas(){
        print("Cargar Tiendas")
        SVProgressHUD.show(withStatus: "Cargando")
        AdministradorBaseDatos.instancia.cargarConvenios(tipo: 2, onSuccess: { tiendasArray in
            DispatchQueue.main.async {
                if tiendasArray.count > 0{
                    self.tiendas = tiendasArray
                    self.tableView.reloadData()
                }
                SVProgressHUD.dismiss()
            }
        })
    }
}
