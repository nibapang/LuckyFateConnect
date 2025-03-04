//
//  SettingVC.swift
//  LuckyFateConnect
//
//  Created by Lucky Fate Connect on 2025/3/4.
//


import UIKit

class LuckySettingVC: UIViewController {
    
    @IBOutlet weak var titleView: UIView!
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleView.transform = CGAffineTransform(rotationAngle: 0.05)  // Slight tilt
        
    }
    
    @IBAction func btnBack(_ sender: Any) {
            navigationController?.popViewController(animated: true)
        }

}
