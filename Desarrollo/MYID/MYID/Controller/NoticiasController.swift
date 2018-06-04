import UIKit
import SVProgressHUD

class NoticiasController: UITableViewController {

    @IBOutlet weak var menuBoton: UIBarButtonItem!
    var noticias: [Noticia] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cargarNoticias()
        self.funcionamientoMenu()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.noticias.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Noticia Cell", for: indexPath) as! NoticiaCell
        cell.viewSeparador.clipsToBounds = false
        cell.viewSeparador.layer.cornerRadius = 10
        cell.viewSeparador.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        cell.titularTexto.text = self.noticias[indexPath.row].titular
        cell.fechaTexto.text = self.noticias[indexPath.row].fecha
        cell.enlace = self.noticias[indexPath.row].enlace
        cell.compartirBoton.tag = indexPath.row
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! NoticiaCell
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "NoticiaContenidoController") as! NoticiaContenidoController
        vc.url = currentCell.enlace
        navigationController?.show(vc, sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 105.0;
    }
    
    func funcionamientoMenu(){
        if self.revealViewController() != nil {
            self.menuBoton.target = self.revealViewController()
            self.menuBoton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    @IBAction func compartirNoticia(_ sender: UIButton) {
        let indexpath = IndexPath(row: sender.tag, section: 0)
        let currentCell = tableView.cellForRow(at: indexpath) as! NoticiaCell
        let noticiaURL =  [NSURL(string: currentCell.enlace)]
        let activityViewController = UIActivityViewController(activityItems: noticiaURL, applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func cargarNoticias(){
        print("Cargar Noticias")
        SVProgressHUD.show(withStatus: "Cargando")
        AdministradorBaseDatos.instancia.cargarNoticias(onSuccess: { noticiasArray in
            DispatchQueue.main.async {
                if noticiasArray.count > 0{
                    self.noticias = noticiasArray
                    self.tableView.reloadData()
                }
                SVProgressHUD.dismiss()
            }
        })
    }
    
}
