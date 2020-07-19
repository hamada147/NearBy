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
        if self.isRealtime {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(self.didClickChangeStatusModeBtn(_:)))
        } else {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Realtime", style: .plain, target: self, action: #selector(self.didClickChangeStatusModeBtn(_:)))
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK:- Actions
    @objc
    func didClickChangeStatusModeBtn(_ button: UIBarButtonItem) {
        if self.isRealtime {
            
        } else {
            
        }
    }
}

extension HomeViewController: UserLocationManagerDelegate {
    func userLocationUpdate(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        print("locations = \(latitude) \(longitude)")
    }
}
