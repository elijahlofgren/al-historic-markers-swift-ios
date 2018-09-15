//
//  DetailViewController.swift
//  AL Historic Markers
//
//  Created by elijahlofgren on 9/15/18.
//

import UIKit
import CoreLocation
import MapKit

class DetailViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var detailDescriptionLabel: UILabel!

    @IBOutlet weak var gpsLocationLabel: UILabel!

    var locationManager: CLLocationManager!
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.timestamp!.description
            }
        }
    }
    
    // Begin adapted from https://stackoverflow.com/a/33591128/908677
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last! as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.map.setRegion(region, animated: true)

        
    }
    // End adapted from https://stackoverflow.com/a/33591128/908677

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gpsLocationLabel.text = "test";

        // Adapted from https://stackoverflow.com/a/33591128/908677
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    var detailItem: Event? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
}

