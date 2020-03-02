//
//  ReadViewController.swift
//  Firebase Demo
//
//  Created by Eisuke Tamatani on 1/16/20.
//  Copyright © 2020 Eisuke. All rights reserved.
//

import UIKit
import Firebase

class ReadViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var employees = [Employee]()
    
    var dBRef:DatabaseReference?
    
    var databaseHandles = [UInt]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        dBRef = Database.database().reference()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        listenForData()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        // Close any DB connections
        for handle in databaseHandles {
            dBRef?.removeObserver(withHandle: handle)
        }
    }
    
    func readDataOnce() {
        
        dBRef?.child("employees").observeSingleEvent(of: .value, with: { (snapshot:DataSnapshot) in
            
            // Get all of the children object of the snapshot
            let snapshots = snapshot.children.allObjects as! [DataSnapshot]
            
            // Go through each child snapshot
            for snap in snapshots {
                
                // Get the snaoshot value as a dictionary
                let employeeDict = snap.value as! [String:Any]
                
                // Get the data for employee
                let name = snap.key
                let age = employeeDict["age"] as! Int
                let likes = employeeDict["likes"] as! String
                let role = employeeDict["role"] as! String
                
                // Create an employee
                let e = Employee(name: name, age: age, likes: likes, role: role)
                
                // Add him/her to the array
                self.employees.append(e)
                
            }
            
            // Reload the tableView
            self.tableView.reloadData()
    
            
        })
        
    }
    
    func listenForData() {
        
        let handle = dBRef?.child("employees").queryOrdered(byChild: "age").queryStarting(atValue: 10).queryEnding(atValue: 30).observe(.value, with: { (snapshot) in
            
            // Get all of the children object of the snapshot
            let snapshots = snapshot.children.allObjects as! [DataSnapshot]
            
            // Clear the employee array before parsing new employee
            self.employees.removeAll()
            
            // Go through each child snapshot
            for snap in snapshots {
                
                // Get the snaoshot value as a dictionary
                let employeeDict = snap.value as! [String:Any]
                
                // Get the data for employee
                let name = snap.key
                let age = employeeDict["age"] as! Int
                let likes = employeeDict["likes"] as! String
                let role = employeeDict["role"] as! String
                
                // Create an employee
                let e = Employee(name: name, age: age, likes: likes, role: role)
                
                // Add him/her to the array
                self.employees.append(e)
                
            }
            
            // Reload the tableView
            self.tableView.reloadData()
        })
        
        // Check if the handle is nil, if nor, then save it
        if handle != nil {
            databaseHandles.append(handle!)
        }
        
    }
}

extension ReadViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get an EmployeeCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell", for: indexPath)
        
        // Set the label for the cell
        let nameLabel = cell.viewWithTag(1) as! UILabel
        let roleLabel = cell.viewWithTag(2) as! UILabel
        
        nameLabel.text = employees[indexPath.row].name
        roleLabel.text = employees[indexPath.row].role
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
}
