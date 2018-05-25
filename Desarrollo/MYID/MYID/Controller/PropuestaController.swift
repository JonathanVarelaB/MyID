import UIKit

class PropuestaController: UITableViewController {
    
    var propuestas = ["propuesta1", "propuesta2", "propuesta3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 120.0;
    }
    
}
