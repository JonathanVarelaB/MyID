import UIKit
import MapKit

class MapaController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var latitud = 0.0
    var longitud = 0.0
    var lugarNombre = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.preparacionMapa()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func preparacionMapa(){
        let coordinada = CLLocationCoordinate2D(latitude: self.latitud, longitude: self.longitud)
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinada, 5000, 5000)
        let lugar = MKPointAnnotation();
        lugar.coordinate = coordinada;
        lugar.title = self.lugarNombre
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.addAnnotation(lugar);
    }
}
