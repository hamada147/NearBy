//
//  BaseUIViewController.swift
//  NearBy
//
//  Created by Ahmed Moussa on 7/19/20.
//  Copyright © 2020 Moussa Tech. All rights reserved.
//

import UIKit

protocol BaseUIViewControllerFunctions: class {
    func setUI()
    func setLocalization()
    func setBinding()
}

class BaseUIViewController: UIViewController {
    
    // MARK:- View Model (ViewModel)
    var baseViewModel: BaseViewModel!
    
    // MARK:- Codded UI
    var vSpinner: UIView? = nil
    var transparentView: UIView!
    
    // MARK:- Init
    init(viewModel: BaseViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.baseViewModel = viewModel
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.setLocalization()
        self.setBinding()
    }
    
    // MARK:- Loading Indicator
    func showSpinner(onView: UIView) {
        if self.vSpinner != nil {
            return
        }
        let spinnerView = UIView(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView(style: .gray)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        self.vSpinner = spinnerView
    }
    
    func removeSpinner() {
        if self.vSpinner != nil {
            DispatchQueue.main.async {
                self.vSpinner?.removeFromSuperview()
                self.vSpinner = nil
            }
        }
    }
    
    // MARK:- Helper Function
    func createTransparentView() {
        self.transparentView = UIView(frame: self.view.frame)
        self.transparentView.alpha = 0.0
        self.transparentView.accessibilityIdentifier = "transparentView"
        self.transparentView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.transparentView)
        self.view.sendSubviewToBack(self.transparentView)
        self.transparentView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.transparentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.transparentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.transparentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}

extension BaseUIViewController: BaseUIViewControllerFunctions {
    func setUI() {
        self.createTransparentView()
    }
    
    func setLocalization() {
        
    }
    
    func setBinding() {
        
    }
}
