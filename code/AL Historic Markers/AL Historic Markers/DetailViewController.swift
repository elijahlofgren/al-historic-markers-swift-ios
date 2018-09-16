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
        
        // TODO: switch to using core data to cache data
        // Asynchronous Http call to your api url, using URLSession:
        // From https://stackoverflow.com/a/35586622/908677
        URLSession.shared.dataTask(with: URL(string: "https://s3.amazonaws.com/al-historic-markers-public-data/al-historic-markers.json")!) { (data, response, error) -> Void in
            // Check if data was received successfully
            if error == nil && data != nil {
                do {
                    // Convert to dictionary where keys are of type String, and values are of any type
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: [[String]]]
                    // Access specific key with value of type String
                    let values = json["values"] as? [[String]]
                    
                    /*for row in values {
                        for cell in row {
                            Swift.print(cell);
                        }*/
                    
                    }
                } catch {
                    // Something went wrong
                }
            }
            }.resume()
    }
    
    // Begin adapted from https://stackoverflow.com/a/33591128/908677
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last! as CLLocation
        
        let userLocation = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        
        // Show a marker on a map (hard-coded for now)
        let marker = Marker(title: "Your location",
                              detailedInfo: "test description",
                              county: "N/A",
                              coordinate: CLLocationCoordinate2D(latitude: userLocation.latitude, longitude: userLocation.longitude))
        map.addAnnotation(marker)
        
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

