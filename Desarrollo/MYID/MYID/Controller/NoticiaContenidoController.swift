import UIKit
import SVProgressHUD

class NoticiaContenidoController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webNoticia: UIWebView!
    var url = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show(withStatus: "Cargando")
        let req = URLRequest(url: URL(string: self.url)!)
        self.webNoticia.delegate = self
        self.webNoticia.loadRequest(req)
    }
    
    func webViewDidFinishLoad(_ webView : UIWebView) {
        SVProgressHUD.dismiss()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
