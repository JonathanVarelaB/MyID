
import UIKit

class NoticiaCell : UITableViewCell {
    @IBOutlet weak var viewSeparador: UIView!
    @IBOutlet weak var viewContenedor: UIView!
    @IBOutlet weak var titularTexto: UILabel!
    @IBOutlet weak var fechaTexto: UILabel!
    @IBOutlet weak var compartirBoton: UIButton!
    var enlace: String = ""
}
