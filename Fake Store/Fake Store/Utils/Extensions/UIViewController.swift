//
//  UIViewController.swift
//  Fake Store
//
//  Created by Javier Picazo Hernández on 4/11/24.
//

import UIKit

// MARK: - UIAlertController methods
extension UIViewController{
    func present(error: Error?, customAction: UIAlertAction? = nil, handler: ((UIAlertAction) -> Void)? = nil) {
        DispatchQueue.main.async {
            self.present(title: "Oops", message: error?.localizedDescription, customAction: customAction, handler: handler)
        }
    }
    
    func present(title: String?, message: String?, customAction: UIAlertAction? = nil, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: handler))
        if let customAction = customAction {
            alert.addAction(customAction)
        }
        
        present(alert, animated: true)
    }
}
