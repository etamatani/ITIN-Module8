//
//  DeleteViewController.swift
//  Firebase Demo
//
//  Created by Eisuke Tamatani on 1/15/20.
//  Copyright © 2020 Eisuke. All rights reserved.
//

import UIKit
import Firebase

class DeleteViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    var dbRef:DatabaseReference?

    override func viewDidLoad() {
        super.viewDidLoad()

        dbRef = Database.database().reference()
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        
        if textField.text == nil || textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            // If textField is empty, then don't continue
            return
        }
        
        dbRef?.child("employees/\(textField.text!)").removeValue()
        
    }
    

}
