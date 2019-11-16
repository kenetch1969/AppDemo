//
//  UIViewController+extension.swift
//  AppDemos
//
//  Created by Juan Gerardo Cruz on 11/16/19.
//  Copyright © 2019 Juan Gerardo Cruz. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.cancel, handler: nil))
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
}
