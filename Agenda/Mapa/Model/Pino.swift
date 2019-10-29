

import UIKit
import MapKit

class Pino: NSObject, MKAnnotation {
    
    var title: String?
    var icon: UIImage?
    var color: UIColor?
    var coordinate: CLLocationCoordinate2D
    
   init(coordenada: CLLocationCoordinate2D) {
        self.coordinate = coordenada
    }
}
