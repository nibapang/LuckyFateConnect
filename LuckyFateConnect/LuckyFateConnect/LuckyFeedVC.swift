//
//  FeedVC.swift
//  LuckyFateConnect
//
//  Created by Lucky Fate Connect on 2025/3/4.
//


import UIKit

class LuckyFeedVC: UIViewController {
    
    @IBOutlet weak var titleView: UIView!
    
    
    

    //MARK: - Declare IBOutlet
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    
    //MARK: - Declare Variable
    
    
    //MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleView.transform = CGAffineTransform(rotationAngle: 0.05)  // Slight tilt
        
        
        
        
        configureStarButtons()
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: - Funcions
    func configureStarButtons() {
        let starButtons = [button1, button2, button3, button4, button5]
        
        for (index, button) in starButtons.enumerated() {
            if #available(iOS 13.0, *) {
                button?.setImage(UIImage(systemName: "star"), for: .normal)
                let largeStarImage = UIImage(systemName: "star", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .regular))
                
                button?.setImage(largeStarImage, for: .normal)
                
            } else {
            }
            button?.tag = index
            button?.addTarget(self, action: #selector(starButtonTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button!)
        }
    }
    
    @objc func starButtonTapped(_ sender: UIButton) {
        let numberOfStars = sender.tag + 1
        fillStars(upTo: numberOfStars)
        adjustButtonSize(sender)
    }
    
    func adjustButtonSize(_ button: UIButton) {
        UIView.animate(withDuration: 0.3) {
            button.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            UIView.animate(withDuration: 0.3) {
                button.transform = CGAffineTransform.identity
            }
        }
    }
    
    func fillStars(upTo numberOfStars: Int) {
        for arrangedSubview in stackView.arrangedSubviews {
            if let starButton = arrangedSubview as? UIButton {
                let starIndex = starButton.tag
                if #available(iOS 13.0, *) {
                    let largeStarImagefill = UIImage(systemName: "star.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .regular))
                    let largeStarImage = UIImage(systemName: "star", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .regular))
                    starButton.setImage(starIndex < numberOfStars ? largeStarImagefill : largeStarImage, for: .normal)
                } else {
                }
            }
        }
    }
    
    func clearAllStars() {
        for arrangedSubview in stackView.arrangedSubviews {
            if let starButton = arrangedSubview as? UIButton {
                if #available(iOS 13.0, *) {
                    let largeStarImage = UIImage(systemName: "star", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .regular))
                    starButton.setImage(largeStarImage, for: .normal)
                } else {
                }
            }
        }
    }
    
    //MARK: - Declare IBAction
    @IBAction func btnSubmit(_ sender: Any) {
        var isStarSelected = false
        for arrangedSubview in stackView.arrangedSubviews {
            if #available(iOS 13.0, *) {
                if let starButton = arrangedSubview as? UIButton, starButton.currentImage == UIImage(systemName: "star.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)) {
                    isStarSelected = true
                    break
                }
            } else {
            }
        }
        
        if isStarSelected {
            clearAllStars()
            showAlert(title: "Thanks for feedback", message: "Your feedback added successfully", from: self)
        } else {
            showAlert(title: "No Selection", message: "Please select a rating before submitting.", from: self)
        }
    }
    func showAlert(title: String, message: String, from viewController: UIViewController) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            viewController.present(alert, animated: true, completion: nil)
        }
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
