//
//  UserLocationManager.swift
//  NearBy
//
//  Created by Ahmed Moussa on 7/19/20.
//  Copyright © 2020 Moussa Tech. All rights reserved.
//

import Foundation
import CoreLocation

protocol UserLocationManagerDelegate: class {
    func userLocationUpdate(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
}

class UserLocationManager: NSObject {
    private let locationManager = CLLocationManager()
    var delegate: UserLocationManagerDelegate? = nil
    
    override init() {
        super.init()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = LocationAccuracy.nearestTenMeters.value()
        }
    }
    
    func startUpdatingLocation(locationData: LocationData) {
        switch locationData {
        case .oneTime:
            self.locationManager.requestLocation()
        case .realtime:
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func stopUpdatingLocation() {
        self.locationManager.stopUpdatingLocation()
    }
    
    enum LocationData {
        case oneTime
        case realtime
    }
    
    private enum LocationAccuracy {
        case bestForNavigation
        case best
        case hundredMeters
        case kilometer
        case threeKilometers
        case nearestTenMeters
        
        func value() -> CLLocationAccuracy {
            switch self {
            case .bestForNavigation:
                return kCLLocationAccuracyBestForNavigation
            case .best:
                return kCLLocationAccuracyBest
            case .hundredMeters:
                return kCLLocationAccuracyHundredMeters
            case .kilometer:
                return kCLLocationAccuracyKilometer
            case .threeKilometers:
                return kCLLocationAccuracyThreeKilometers
            case .nearestTenMeters:
                return kCLLocationAccuracyNearestTenMeters
            }
        }
    }
}

extension UserLocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        #if DEBUG
        print("latitude: \(locValue.latitude), longitude: \(locValue.longitude)")
        #endif
        self.delegate?.userLocationUpdate(latitude: locValue.latitude, longitude: locValue.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        #if DEBUG
        print(error)
        #endif
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways:
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = LocationAccuracy.nearestTenMeters.value()
        case .authorizedWhenInUse:
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = LocationAccuracy.nearestTenMeters.value()
        case .denied:
            break
        case .notDetermined:
            break
        case .restricted:
            break
        @unknown default:
            #if DEBUG
            print("not handled CL Authorization Status \(status)")
            #endif
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFinishDeferredUpdatesWithError error: Error?) {
        #if DEBUG
        print(error)
        #endif
    }
}
