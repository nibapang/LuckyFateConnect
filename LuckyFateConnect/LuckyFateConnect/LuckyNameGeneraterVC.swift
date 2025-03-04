//
//  NameGeneraterVC.swift
//  LuckyFateConnect
//
//  Created by Lucky Fate Connect on 2025/3/4.
//


import UIKit

@available(iOS 15.0, *)
class LuckyNameGeneraterVC: UIViewController {
    
    
    let girlNames: [String] = [
        // 🌸 Classic & Elegant Names
        "Isabella", "Sophia", "Olivia", "Charlotte", "Amelia",
        "Evelyn", "Victoria", "Katherine", "Margaret", "Josephine",
        
        // 🌿 Nature-Inspired Names
        "Lily", "Rose", "Jasmine", "Hazel", "Ivy",
        "Violet", "Daisy", "Willow", "Autumn", "Flora",
        
        // ☀️ Bright & Cheerful Names
        "Sunny", "Joy", "Hope", "Harmony", "Serena",
        "Celeste", "Luna", "Aurora", "Dawn", "Stella",
        
        // 🌍 Culturally Beautiful Names
        "Aisha", "Zara", "Leila", "Aria", "Anaya",
        "Esme", "Freya", "Sofia", "Elena", "Naomi",
        
        // 🎵 Musical & Artistic Names
        "Melody", "Cadence", "Lyric", "Symphony", "Sonata",
        "Rhapsody", "Harmony", "Echo", "Aria", "Muse",
        
        // 💎 Royal & Majestic Names
        "Alexandra", "Catherine", "Diana", "Genevieve", "Elizabeth",
        "Anastasia", "Beatrice", "Eleanor", "Madeleine", "Theodora",
        
        // ✨ Modern & Trendy Names
        "Ava", "Zoe", "Riley", "Mila", "Harper",
        "Brooklyn", "Skylar", "Peyton", "Emery", "Kenzie",
        
        // 🌙 Mystic & Unique Names
        "Nova", "Selene", "Celestia", "Lyra", "Astra",
        "Phoenix", "Solara", "Orionna", "Zephyra", "Sienna",
        
        // ❤️ Sweet & Cute Names
        "Ellie", "Annie", "Maggie", "Winnie", "Tessa",
        "Mia", "Lacey", "Nina", "Clara", "Bonnie",
        
        // 🌊 Ocean & Water-Inspired Names
        "Marina", "Pearl", "Oceana", "Coral", "Isla",
        "Naia", "Mira", "Nerissa", "Sandy", "River"
    ]
    
    
    
    
    let boyNames: [String] = [
        // 🔥 Classic & Strong Names
        "James", "William", "Benjamin", "Alexander", "Henry",
        "Daniel", "Michael", "Thomas", "Edward", "Samuel",
        
        // 🌿 Nature-Inspired Names
        "River", "Ash", "Forrest", "Cedar", "Rowan",
        "Stone", "Everest", "Basil", "Flint", "Hawthorn",
        
        // ☀️ Bright & Cheerful Names
        "Leo", "Felix", "Asher", "Ray", "Eli",
        "Sol", "Jude", "Sunny", "Apollo", "Dylan",
        
        // 🌍 Culturally Beautiful Names
        "Omar", "Hassan", "Rafael", "Diego", "Mateo",
        "Elias", "Zayn", "Adrian", "Marco", "Santiago",
        
        // 🎵 Musical & Artistic Names
        "Lyric", "Harmony", "Reed", "Cadence", "Drake",
        "Elton", "Bowie", "Lennon", "Hendrix", "Miles",
        
        // 💎 Royal & Majestic Names
        "Arthur", "Frederick", "Theodore", "Augustus", "Sebastian",
        "Maximilian", "Reginald", "Leopold", "Philip", "Constantine",
        
        // ✨ Modern & Trendy Names
        "Aiden", "Jaxon", "Grayson", "Maverick", "Zayden",
        "Carter", "Beckett", "Easton", "Liam", "Nolan",
        
        // 🌙 Mystic & Unique Names
        "Orion", "Cosmo", "Zephyr", "Sirius", "Atlas",
        "Phoenix", "Raiden", "Kairo", "Lucian", "Xavier",
        
        // ❤️ Sweet & Cute Names
        "Teddy", "Ollie", "Milo", "Archie", "Jamie",
        "Charlie", "Finn", "Noah", "Luca", "Eddie",
        
        // 🌊 Ocean & Water-Inspired Names
        "Kai", "Caspian", "Marlin", "Reef", "Tide",
        "Brooks", "Hudson", "Bay", "Nile", "Ronan"
    ]
    
    
    
    
    
    @IBOutlet weak var contentView: UIStackView!
    @IBOutlet weak var txtFatherName: UITextField!
    @IBOutlet weak var txtMotherName: UITextField!
    @IBOutlet weak var txtFamilyTitle: UITextField!
    @IBOutlet weak var birthDatePicker: UIDatePicker!
    @IBOutlet weak var birthTimePicker: UIDatePicker!
    @IBOutlet weak var generatedNameLabel: UILabel!
    @IBOutlet weak var tapButton: UIButton!
    @IBOutlet weak var gnederPullDownButton: UIButton!
    
    var selectedGender: String?
    var currentStep = 0 // Track current view index
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtFatherName.delegate = self
        txtMotherName.delegate = self
        txtFamilyTitle.delegate = self
        
        
        selectedGender = "Boy"
        gnederPullDownButton.setTitle("Boy", for: .normal)
        updateStackView(step: 0)
        
       
        tapButton.setTitle("Next", for: .normal)
        
        setupGenderSelection()
       
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        
    }
    
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    
    func setupGenderSelection() {
        gnederPullDownButton.showsMenuAsPrimaryAction = true
        gnederPullDownButton.changesSelectionAsPrimaryAction = true
        
        let optionClosure = { (action: UIAction) in
            self.selectedGender = action.title
            self.gnederPullDownButton.setTitle(action.title, for: .normal)
        }
        
        gnederPullDownButton.menu = UIMenu(children: [
            UIAction(title: "Boy", handler: optionClosure),
            UIAction(title: "Girl", handler: optionClosure)
            
        ])
        
        
    }

    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    @IBAction func tapButtonAction(_ sender: UIButton) {
        if currentStep == 0 {
            // Move to Second View (Name Input)
            currentStep = 1
            tapButton.setTitle("Create", for: .normal)
        } else if currentStep == 1 {
            // Generate Name and Move to Third View
            generateName()
            currentStep = 2
            tapButton.setTitle("Reset", for: .normal)
        } else {
            // Reset to First View
            resetInputs()
            currentStep = 0
            tapButton.setTitle("Next", for: .normal)
        }
        
        updateStackView(step: currentStep)
    }
    
    
    func updateStackView(step: Int) {
        // Ensure the step index is within range
        guard step < contentView.arrangedSubviews.count else { return }

        // Animate hiding all views
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.arrangedSubviews.forEach { $0.alpha = 0 }
        }) { _ in
            // Hide all arranged subviews
            for view in self.contentView.arrangedSubviews {
                view.isHidden = true
            }

            // Show the selected view
            let selectedView = self.contentView.arrangedSubviews[step]
            selectedView.isHidden = false
            selectedView.alpha = 0
            
            // Animate the new view appearing with a sliding effect
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                selectedView.alpha = 1
                selectedView.transform = CGAffineTransform(translationX: 0, y: 0) // Reset position
            }, completion: nil)
        }
    }
    
    
    
    func generateName() {
        let fatherName = txtFatherName.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let motherName = txtMotherName.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let familyTitle = txtFamilyTitle.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        let birthDate = birthDatePicker.date // ✅ Get Birth Date
        let birthTime = birthTimePicker.date // ✅ Get Birth Time

        guard !fatherName.isEmpty, !motherName.isEmpty, let gender = selectedGender else {
            generatedNameLabel.text = "Please fill in all fields and select a gender"
            return
        }
        
        let generatedName = createUniqueName(
            fatherName: fatherName,
            motherName: motherName,
            familyTitle: familyTitle,
            birthDate: birthDate,
            birthTime: birthTime,
            isBoy: gender == "Boy"
        )
        
        generatedNameLabel.text = "\(generatedName)"
        print(generatedName)
    }
    
    
    
    func createUniqueName(fatherName: String, motherName: String, familyTitle: String, birthDate: Date, birthTime: Date, isBoy: Bool) -> String {
        
        let fatherPart = fatherName.prefix(2) // First 2 letters of Father's Name
        let motherPart = motherName.suffix(2) // Last 2 letters of Mother's Name
        
        // Format birth date into initials (e.g., day + hour)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd" // Extract day (e.g., 05)
        let birthDay = dateFormatter.string(from: birthDate)
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH" // Extract hour (e.g., 14)
        let birthHour = timeFormatter.string(from: birthTime)
        
        let namePrefix = "\(fatherPart)\(motherPart)\(birthDay)\(birthHour)".capitalized

        // Pick a random name from the correct list
        let nameList = isBoy ? boyNames : girlNames
        let matchingName = nameList.first { $0.hasPrefix(namePrefix) } ?? nameList.randomElement() ?? "Unknown"

        // Add family title if available
        return familyTitle.isEmpty ? matchingName : "\(matchingName) \(familyTitle)"
    }
    
    
    
    func resetInputs() {
        txtFatherName.text = ""
        txtMotherName.text = ""
        txtFamilyTitle.text = ""
        generatedNameLabel.text = ""
    }
}



@available(iOS 15.0, *)
extension LuckyNameGeneraterVC: UITextFieldDelegate {

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
