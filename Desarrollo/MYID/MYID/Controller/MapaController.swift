import UIKit
import MapKit

class MapaController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.preparacionMapa()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func preparacionMapa(){
        let coordinada = CLLocationCoordinate2D(latitude: 9.932316199999999, longitude: -84.03103390000001)
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinada, 4000, 4000)
        let lugar = MKPointAnnotation();
        lugar.coordinate = coordinada;
        lugar.title = "Pops"
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.addAnnotation(lugar);
    }
}
