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

    let itemArray = ["Do Drugs", "Smoke Weed", "Take a shit"]    //11
    
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
           tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark   //15
            }
        
        tableView.deselectRow(at: indexPath, animated: true)   //14 back on notes
        
        
    }
    
    
    
    
    
    
    
    
    }




