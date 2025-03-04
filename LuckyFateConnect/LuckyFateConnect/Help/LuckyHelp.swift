//
//  LuckyHelp.swift
//  LuckyFateConnect
//
//  Created by Lucky Fate Connect on 2025/3/4.
//


import UIKit

func showAlert(on viewController: UIViewController, title: String, message: String) {
    // Create the alert controller
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    // Add an OK action to the alert
    let okAction = UIAlertAction(title: "OK", style: .default) { _ in
        viewController.navigationController?.popViewController(animated: true)
    }
    alert.addAction(okAction)
    
    viewController.present(alert, animated: true, completion: nil)
}
