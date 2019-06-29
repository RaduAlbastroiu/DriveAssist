//
//  MapController.swift
//  DriveAssist
//
//  Created by Radu Albastroiu on 05/06/2019.
//  Copyright © 2019 Radu Albastroiu. All rights reserved.
//

import Foundation
import MapKit

class MapController: NSObject, MKMapViewDelegate {
    
    private var mkMapView: MKMapView
    private var shouldCenterMapOnLocation: Bool
    
    private var previousLocations: [CLLocation]
    
    var currentLocation: CLLocation?
    var showIssues: Bool
    var currentSpeed = 0.0
    var viewController: ViewController
    
    init(mapView: MKMapView, viewController: ViewController) {
        self.showIssues = false
        self.mkMapView = mapView
        self.shouldCenterMapOnLocation = true
        mapView.showsUserLocation = true
        mapView.showsTraffic = true
        mapView.showsCompass = true
        mapView.showsScale = true
        self.viewController = viewController
        
        self.previousLocations = []
        
        super.init()
        mapView.delegate = self
    }
    
    func round2(_ value: Double, toNearest: Double) -> Double {
        return round(value / toNearest) * toNearest
    }
    
    func centerMapOnLocation() {
        shouldCenterMapOnLocation = true
    }
    
    private func centerMapOn(location: CLLocation, withRadius radius: Double) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: radius, longitudinalMeters: radius)
        mkMapView.setRegion(coordinateRegion, animated: true)
    }
    
    private func computeSpeed() {
        if(previousLocations.count > 10) {
            var newPreviousLocations = [CLLocation]()
            for index in previousLocations.count - 4 ... previousLocations.count {
                newPreviousLocations.append(previousLocations[index])
            }
            
            previousLocations = newPreviousLocations
        }
        
        if( previousLocations.count > 3) {
            var totalSpeed = 0.0
            
            for index in previousLocations.count...previousLocations.count - 2 {
                totalSpeed += previousLocations[index].speed
            }
            
            currentSpeed = totalSpeed / 3.0
        }
    }
}

extension MapController: LocationManagerDelegate {
    func locationUpdated(didUpdateLocations locations: [CLLocation]) {
        if(shouldCenterMapOnLocation) {
            if(locations.count > 0) {
                centerMapOn(location: locations[0], withRadius: 1000)
                shouldCenterMapOnLocation = false
                previousLocations.append(locations[0])
            }
        }
        currentLocation = locations[0]
    }
}
