//
//  HomeViewController.swift
//  NearBy
//
//  Created by Ahmed Moussa on 7/19/20.
//  Copyright © 2020 Moussa Tech. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: BaseUIViewController {
    
    // MARK:- Variables
    let userLocationManager: UserLocationManager = UserLocationManager()
    var isRealtime = true
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userLocationManager.delegate = self
        self.title = "Home"
        self.isRealtime = UserDefaultManager.shared.get(for: .isRealtime, defaultValue: true)
        self.updateNavigationItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.isRealtime {
            self.userLocationManager.startUpdatingLocation(locationData: .realtime)
        } else {
            self.userLocationManager.startUpdatingLocation(locationData: .oneTime)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.userLocationManager.stopUpdatingLocation()
    }
    
    // MARK:- Actions
    @objc
    func didClickChangeStatusModeBtn(_ button: UIBarButtonItem) {
        self.userLocationManager.stopUpdatingLocation()
        if self.isRealtime {
            UserDefaultManager.shared.set(false, for: .isRealtime)
            self.didClickOnRealtimeBtn()
        } else {
            UserDefaultManager.shared.set(true, for: .isRealtime)
            self.didClickOnRefreshBtn()
        }
        self.isRealtime.toggle()
        self.updateNavigationItem()
    }
    
    func didClickOnRealtimeBtn() {
        self.userLocationManager.startUpdatingLocation(locationData: .oneTime)
    }
    
    func didClickOnRefreshBtn() {
        self.userLocationManager.startUpdatingLocation(locationData: .realtime)
    }
    
    func updateNavigationItem() {
        if self.isRealtime {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(self.didClickChangeStatusModeBtn(_:)))
        } else {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Realtime", style: .plain, target: self, action: #selector(self.didClickChangeStatusModeBtn(_:)))
        }
    }
}

extension HomeViewController: UserLocationManagerDelegate {
    func userLocationUpdate(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        print("locations = \(latitude) \(longitude)")
    }
}
