//
//  UIExtensions.swift
//  omdbMovieChallenge
//
//  Created by *_* on 1/21/21.
//

import UIKit
import Foundation

extension UISearchBar {
    private var activityIndicator: UIActivityIndicatorView? {
        return searchTextField.leftView?.subviews.compactMap{ $0 as? UIActivityIndicatorView}.first
    }
    
    public func start() {
        if (activityIndicator==nil){
            activityIndicator?.startAnimating()
        }
    }
}

extension UIViewController {
    func showAlert(title: String, alertMessage: String) {
        let alert = UIAlertController(title: title, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
