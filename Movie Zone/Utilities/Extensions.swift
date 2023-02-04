//
//  Extensions.swift
//  Movie Zone
//
//  Created by Monish Chaudhari on 04/02/23.
//

import Foundation
import UIKit

//MARK: UIViewController
extension UIViewController {
    func showAlert(_ alert_title: String, alert_message:String) {
        let alertController = UIAlertController(title: alert_title, message: alert_message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated:true, completion:nil)
    }
    
    ///Use this alert to force dismiss or pop view controller on tap on button
    func showAlertWithForceBack(_ alert_title: String, alert_message:String, action_title:String = "OK") {
        let alertController = UIAlertController(title: alert_title, message: alert_message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: action_title, style: .default) { (action) in
            
            if self.navigationController != nil {
                self.navigationController?.popViewController(animated: true)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        alertController.addAction(defaultAction)
        present(alertController, animated:true, completion:nil)
    }
}


//MARK: UIView
extension UIView {
    func makeRoundedCorners() {
        self.layer.cornerRadius = self.frame.height/2
    }
}
