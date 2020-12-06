//
//  ViewController.swift
//  Project2
//
//  Created by user180084 on 11/23/20.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var LonLabel: UILabel!
    @IBOutlet weak var LocButton: UIButton!
    @IBOutlet weak var LatLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager?
    var currentLocation:CLLocation? = nil;
    let initialLocation = CLLocation(latitude:  21.282778, longitude: -157.829444)
    let newPin = MKPointAnnotation()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        
        mapView.centerToLocation(initialLocation);
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }

    @IBAction func getLocation(_ sender: Any	) {
        locationManager?.requestLocation();
        var latitude = String(format: "%f" , locationManager?.location?.coordinate.latitude ?? self.initialLocation.coordinate.latitude);
        var longitude = String(format: "%f" , locationManager?.location?.coordinate.longitude ?? self.initialLocation.coordinate.longitude);
        LatLabel.text = "Latitude: \(latitude)"
        LonLabel.text = "Longitude: \(longitude)"
        mapView.centerToLocation(locationManager?.location ?? self.initialLocation)
   

    }
    
    
}
private extension MKMapView {
    
    func centerToLocation(
        _ location: CLLocation, regionRadius: CLLocationDistance = 1000)
    {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}

