import UIKit
import SVProgressHUD

class OtrosController: UITableViewController {
    
    var otros: [Convenio] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cargarOtrosConvenios()
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
        return self.otros.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Convenio Cell", for: indexPath) as! ConvenioCell
        cell.descripcionTexto.text = self.otros[indexPath.row].descripcion
        cell.lugarTexto.text = self.otros[indexPath.row].lugar
        cell.tiempoTexto.text = self.otros[indexPath.row].tiempo
        cell.longitud = Double(self.otros[indexPath.row].longitud)!
        cell.latitud = Double(self.otros[indexPath.row].latitud)!
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 80.0;
    }
    
    func cargarOtrosConvenios(){
        print("Cargar Otros Convenios")
        SVProgressHUD.show(withStatus: "Cargando")
        AdministradorBaseDatos.instancia.cargarConvenios(tipo: 3, onSuccess: { otrosArray in
            DispatchQueue.main.async {
                if otrosArray.count > 0{
                    self.otros = otrosArray
                    self.tableView.reloadData()
                }
                SVProgressHUD.dismiss()
            }
        })
    }
}
