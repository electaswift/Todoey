//
//  ViewController.swift
//  Todoey
//
//  Created by Bryan on 3/7/18.
//  Copyright © 2018 BK. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {             //5. 6 is to change name of this vc to "ToDoListViewController"  7 is on notes

   

    var itemArray = ["Do Drugs", "Smoke Weed", "Take a shit"]    //11
    
    let defaults = UserDefaults.standard   //30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [String] {   //33 using if let cause if defaults.array has no key todolistarray, then app crashes
            itemArray = items
        }
    }
    
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {  //12
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {//13
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
    
    
    cell.textLabel?.text = itemArray[indexPath.row]
    
    return cell
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
      
            
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            }else {
           tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark   //15. 16 on notes. 
            }
        
        tableView.deselectRow(at: indexPath, animated: true)   //14 back on notes
        
        
    }
    
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {  //20
        
        var textField = UITextField()     //27
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert) //22
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in   //23
           // print("Success") 23
         
            self.itemArray.append(textField.text!)   //28
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")   //31  everything you save to defaults gets saved to a plist file so you always need a key to retrieve the item. in order to access the defaults, you need file path of our sandbox that our app runs, we need the IDof the simulator and the ID of the sandbox where our app lives in. 32 is on appdelegate
            
            self.tableView.reloadData()  //29
           
            }

        
        
        alert.addTextField { (alertTextField) in      //it knows the parameter type is that of textfield 26
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)  //24
        
     present(alert, animated: true, completion: nil)  //25
        
        
    }
    
    
    
    
    
    
    
    }




