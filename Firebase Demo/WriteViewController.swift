//
//  WriteViewController.swift
//  Firebase Demo
//
//  Created by Eisuke Tamatani on 1/15/20.
//  Copyright © 2020 Eisuke. All rights reserved.
//

import UIKit
import Firebase

class WriteViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    var dbRef:DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Getting database reference
        dbRef = Database.database().reference()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any respurce that can be recreated
    }
    

    @IBAction func addTapped(_ sender: Any) {
        
        if textField.text == nil || textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            // If textField is empty, then don't continue
            return
        }
        
        // Add the employee to the database
        var employeeData: [String : Any] = ["age":23, "likes":"ice cream","role":"admin","name":textField.text!]
        
        dbRef?.child("employees").childByAutoId().setValue(employeeData, withCompletionBlock: { (error, ref) in
            
            // Check if the write operation was successful
            if error == nil {
                // Write operation was successful
            }
            else {
                // Unsuccessful
            }
        })
        
    }
    
}
