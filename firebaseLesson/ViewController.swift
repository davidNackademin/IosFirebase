//
//  ViewController.swift
//  firebaseLesson
//
//  Created by David Svensson on 2017-03-30.
//  Copyright © 2017 David Svensson. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    var ref: FIRDatabaseReference!
    var items: [Item] = []
    let cellReusableId = "cellReusableIdentifier"
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        let paron = Item(name: "äpple")
        
        ref.child("items").childByAutoId().setValue(paron.toAnyObject())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
//        ref.child("users").child("001").setValue(["username":"david" ])
//        ref.child("users").child("002").setValue(["username":"susan" ])
//        ref.child("users").child("003").setValue(["username":"laura" ])
        
//        let mjol = Item(name: "mjöl")
//        let morot = Item(name: "morötter")
//        let ost = Item(name: "ost")
//
//        ref.child("items").child(mjol.name).setValue(mjol.toAnyObject())
//        ref.child("items").child(morot.name).setValue(morot.toAnyObject())
//        ref.child("items").child(ost.name).setValue(ost.toAnyObject())
//
        ref.child("items").observe(.value, with: {(snapshot) in
            
            var newItems: [Item] = []
            
            for item in snapshot.children {
                let listItem = Item(snapshot: item as! FIRDataSnapshot)
                newItems.append(listItem)
               // print(listItem.name)
            }
            
            self.items = newItems
            self.tableView.reloadData()
        })
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReusableId, for: indexPath)
        
        if let label = cell.textLabel {
            label.text = items[indexPath.row].name
        }
        
        return cell
    }
    
    
    

}
