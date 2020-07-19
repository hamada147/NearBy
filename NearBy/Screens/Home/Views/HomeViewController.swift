//
//  HomeViewController.swift
//  NearBy
//
//  Created by Ahmed Moussa on 7/19/20.
//  Copyright © 2020 Moussa Tech. All rights reserved.
//

import UIKit
import CoreLocation
import Toast_Swift

class HomeViewController: BaseUIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var venuesTableView: UITableView!
    
    // MARK:- Variables
    let userLocationManager: UserLocationManager = UserLocationManager()
    var isRealtime = true
    
    // MARK:- ViewModel (HomeViewModel)
    var vm: HomeViewModel {
        return self.baseViewModel as! HomeViewModel
    }
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.venuesTableView.register(UINib(nibName: "VenueTableViewCell", bundle: nil), forCellReuseIdentifier: "VenueTableViewCell")
        self.venuesTableView.delegate = self
        self.venuesTableView.dataSource = self
        self.venuesTableView.tableFooterView = UIView()
        
        self.userLocationManager.delegate = self
        self.title = "Near By"
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
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Realtime", style: .plain, target: self, action: #selector(self.didClickChangeStatusModeBtn(_:)))
        } else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(self.didClickChangeStatusModeBtn(_:)))
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.venues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VenueTableViewCell") as! VenueTableViewCell
        let venue = self.vm.venues[indexPath.row]
        cell.vm = VenueTableCellViewModel(title: venue.name, summary: venue.desc)
        return cell
    }
}

extension HomeViewController: UserLocationManagerDelegate {
    func userLocationUpdate(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        if self.vm.venues.count > 0 {
            self.removeSpinner()
        } else {
            self.showSpinner(onView: self.view)
        }
        
        self.vm.getVenus(ll: "\(latitude),\(longitude)", onSuccess: { (gotData) in
            DispatchQueue.main.async {
                self.removeSpinner()
                if gotData {
                    self.venuesTableView.reloadData()
                }
            }
        }, onError: { (error) in
            self.view.makeToast(error.errorMessage)
            #if DEBUG
            print(error.errorMessage)
            #endif
        })
    }
}
