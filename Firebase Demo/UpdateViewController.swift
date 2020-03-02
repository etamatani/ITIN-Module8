//
//  UpdateViewController.swift
//  Firebase Demo
//
//  Created by Eisuke Tamatani on 1/15/20.
//  Copyright © 2020 Eisuke. All rights reserved.
//

import UIKit
import Firebase

class UpdateViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    var dbRef:DatabaseReference?

    override func viewDidLoad() {
        super.viewDidLoad()

        dbRef = Database.database().reference()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Disposeof any resources that can be recreated
    }
    
    @IBAction func updateTapped(_ sender: Any) {
        
        // Start with zero age
        var age:Int? = 0
        
        // If the user actually put something in the textfield, themn try to convert it to an int
        if textField.text != nil && textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            age = Int(textField.text!) ?? 0
        }
        
        addAgeToMike(AgeToAdd: age!)
    }
    
    func addAgeToMike(AgeToAdd:Int) {
        
        dbRef?.child("employees/Mike/age").runTransactionBlock({ (currentData) -> TransactionResult in
            
            // Check if the current data is nil
            if let currentAge = currentData.value as? Int {
                

                // Update the age
                let newAge = currentAge + AgeToAdd
                
                // Set it back to the currentData
                currentData.value = newAge
                
                // Return transction result
                return TransactionResult.success(withValue: currentData)
                
            }
            
            // Return the transaction result
            return TransactionResult.success(withValue: currentData)
        })
        
    }
    
    func updateLikes() {
        
        if textField.text == nil || textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                   
                   // If textField is empty, then don't continue
                   return
               }
               
               var updates = ["employees/Tom/role":"network admin", "employees/Sandra/role":"HR"]
               
               dbRef?.updateChildValues(updates)
        
    }
    
}
