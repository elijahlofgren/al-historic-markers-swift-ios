//
//  Marker.swift
//  AL Historic Markers
//
//  Created by elijahlofgren on 9/16/18.
//  Based on this tutorial: https://www.raywenderlich.com/548-mapkit-tutorial-getting-started

import MapKit

class Marker: NSObject, MKAnnotation {
    let title: String?
    let name: String
    let county: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, name: String, county: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.name = name
        self.county = county
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return county
    }
}
