//
//  ViewController.swift
//  Todoey
//
//  Created by Bryan on 3/7/18.
//  Copyright © 2018 BK. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {             //5. 6 is to change name of this vc to "ToDoListViewController"  7 is on notes

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    var itemArray = ["Do Drugs", "Smoke Weed", "Take a shit"]    //11
    
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




