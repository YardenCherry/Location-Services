//
//  LocationManager.swift
//  LocationServices
//
//  Created by Nadav Avnon on 11/07/2024.
//

import Foundation
import CoreLocation


protocol LocationManagerDelegate : AnyObject {
    func didUpdateLocation(location: Location)
    func didFailWithError(err: Error)
}

struct Location {
    var lat: Double
    var lng: Double
}


class LocationManager : NSObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    
    weak var delegate: LocationManagerDelegate?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocation() {
        
        let status = locationManager.authorizationStatus
        
        switch status {
            case .notDetermined:
                self.locationManager.requestWhenInUseAuthorization()
            case .authorizedAlways, .authorizedWhenInUse:
                self.locationManager.startUpdatingLocation()
            default:
                delegate?.didFailWithError(err: NSError(domain: "LocationErrorDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "Location Permissions denied"]))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            self.locationManager.startUpdatingLocation()
        } else if status == .denied || status == .restricted {
            delegate?.didFailWithError(err: NSError(domain: "LocationErrorDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "Location Permissions denied"]))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            delegate?.didUpdateLocation(location:Location(lat: lastLocation.coordinate.latitude, lng: lastLocation.coordinate.longitude))
        }
        self.locationManager.stopUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        delegate?.didFailWithError(err: error)
    }
    
}
