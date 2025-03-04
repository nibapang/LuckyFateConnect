//
//  FindLuckyNumberVC.swift
//  LuckyFateConnect
//
//  Created by Lucky Fate Connect on 2025/3/4.
//


import UIKit
import TextFieldEffects

class LuckyFindNumberVC: UIViewController, UICalendarViewDelegate{
    
    @IBOutlet weak var contentStack: UIStackView!
    @IBOutlet weak var txtName: AkiraTextField!
    @IBOutlet weak var birthDate: UIDatePicker!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var segmentControll: UISegmentedControl!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var loadingTime: UIActivityIndicatorView!
    @IBOutlet weak var findLuckyNumberButton: UIButton! // Add button outlet
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtName.delegate = self
        
        loadingTime.hidesWhenStopped = true
        segmentControll.selectedSegmentIndex = 0
        handleSegmentChange(segmentControll)
        dobLabel.isHidden = true
        
        segmentControll.addTarget(self, action: #selector(handleSegmentChange(_:)), for: .valueChanged)
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handlerView))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handlerView(){
        view.endEditing(true)
    }
    
    
    
    @objc func handleSegmentChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            birthDate.date = Date()
            birthDate.isUserInteractionEnabled = false
            dobLabel.isHidden = true
        } else { // "Always" selected
            birthDate.isUserInteractionEnabled = true
            dobLabel.isHidden = false
        }
    }
    
    
   
    
    
    
    
    
    
    
    
    @IBAction func btnFindLuckyNumber(_ sender: Any) {
        let name = txtName.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        guard !name.isEmpty else {
            numberLabel.text = "Please enter your name!"
            return
        }
        
        loadingTime.startAnimating()
        findLuckyNumberButton.isEnabled = false
        numberLabel.isHidden = true
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.loadingTime.stopAnimating()
            self.findLuckyNumberButton.isEnabled = true
            
            let luckyNumber = self.generateLuckyNumber(name: name, birthdate: self.birthDate.date)
            
            
            self.numberLabel.text = "\(luckyNumber)"
            self.numberLabel.isHidden = false
            
            
        }
        
    
    }
    
    func generateLuckyNumber(name: String, birthdate: Date) -> Int {
       
        let nameAsciiSum = name.uppercased().unicodeScalars.reduce(0) { $0 + Int($1.value) }
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let birthdateString = dateFormatter.string(from: birthdate)
        
        let birthdateSum = birthdateString.compactMap { Int(String($0)) }.reduce(0, +)
        
        
        let finalLuckyNumber = (nameAsciiSum + birthdateSum) % 9
        return finalLuckyNumber == 0 ? 9 : finalLuckyNumber
    }
    
    

    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
}




extension LuckyFindNumberVC: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // return NO to disallow editing.
        print("TextField should begin editing method called")
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        // became first responder
        print("TextField did begin editing method called")
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
        print("TextField should snd editing method called")
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
        print("TextField did end editing method called")
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        // if implemented, called in place of textFieldDidEndEditing:
        print("TextField did end editing with reason method called")
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // return NO to not change text
        print("While entering the characters this method gets called")
        return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        // called when clear button pressed. return NO to ignore (no notifications)
        print("TextField should clear method called")
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // called when 'return' key pressed. return NO to ignore.
        print("TextField should return method called")
        textField.resignFirstResponder()
        return true
    }

}
