//
//  Utilities.swift
//  NearbyAirports
//
//  Created by Sajith Ramavarma on 14/06/19.
//  Copyright © 2019 Sajith Ramavarma. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func alert(message: String, title: String = "Alert") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func showLoading(){
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
            present(alert, animated: true, completion: nil)
        
    }
    
}

