//
//  ViewController.swift
//  Todoey
//
//  Created by Bryan on 3/7/18.
//  Copyright © 2018 BK. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {             //5. 6 is to change name of this vc to "ToDoListViewController"  7 is on notes

   

    //var itemArray = ["Do Drugs", "Smoke Weed", "Take a shit"]    //11
    var itemArray = [Item]()    //array of item objects  36
    
   // let defaults = UserDefaults.standard   //30
    
      let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist") //54
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    /*let newItem = Item()    //35
        newItem.title = "Find Mike"
        itemArray.append(newItem) //37
        
        let newItem2 = Item()    //38
        newItem2.title = "Buy Eggos"
        itemArray.append(newItem2)
        
        let newItem3 = Item()    //39
        newItem3.title = "Destroy Demogorgon"
        itemArray.append(newItem3) */
        
        loadItems()  //63 take the above out. 64 on item class 
        
        
        
     // if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {   //33 using if let cause if defaults.array has no key todolistarray, then app crashes.  34 is creating a new class. file new file, new swift file.    53 is uncommenting this code out.  the app will crash cause we are trying to user userdefaults by putting in our own custom made objects in an array as the value which is beyonod the scope of user defaults.
    //  itemArray = items
  //    }
    }
    
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {  //12
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {//13
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
    
    
   // cell.textLabel?.text = itemArray[indexPath.row]
        
        let item = itemArray[indexPath.row]    //48
        
        cell.textLabel?.text = item.title   //49  48,49 better than 40.
        
      //  cell.textLabel?.text = itemArray[indexPath.row].title  //40
        
        //Ternary operator ==>
        // value = condition ? valueIfTrue : valueIfFalse
        // we have a condition and check to see if true or false. the value of condition is dependent on whether its true or false
        
      //  cell.accessoryType = item.done == true ? .checkmark : .none   51
        
        //value above is the cell.accessorytype. the condition is item.done.
        
        cell.accessoryType = item.done ? .checkmark : .none  //52
        
        
     /*   if item.done == true {    //50 but can be cut down even further by 51
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        } */
        
    
    /*    if itemArray[indexPath.row].done == true {    //45
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        } */
        
    return cell
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done    //47 better way to put it than 44
        
       /* if itemArray[indexPath.row].done == false {      //44
            itemArray[indexPath.row].done = true
        } else {
            itemArray[indexPath.row].done = false
        }  */
        
        saveItems() //60 and get rid of the below
        
        //tableView.reloadData() //46 forces the tableview to call its datasource methods again so that it reloads the data meant to be inside
            
   //     if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
    //        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    //        }else {
   //        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark   //15. 16 on notes.
   //         }
        
        tableView.deselectRow(at: indexPath, animated: true)   //14 back on notes
        
        
    }
    
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {  //20
        
        var textField = UITextField()     //27
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert) //22
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in   //23
           // print("Success") 23
         
            //self.itemArray.append(textField.text!)   //28
            
            let newItem = Item()      //41
            newItem.title = textField.text!   //42
            
            //self.itemArray.append(textField.text!)
            self.itemArray.append(newItem)  //43
            
          /*  let encoder = PropertyListEncoder()
            
            do {
            
            let data = try encoder.encode(self.itemArray) //55   //data is whatever was returned by the method encode i think. 56 is on item 
                try data.write(to: self.dataFilePath!)
            } catch {
                print("Error encoding item array, \(error)")
            }
            
        //    self.defaults.set(self.itemArray, forKey: "ToDoListArray")   //31  everything you save to defaults gets saved to a plist file so you always need a key to retrieve the item. in order to access the defaults, you need file path of our sandbox that our app runs, we need the IDof the simulator and the ID of the sandbox where our app lives in. 32 is on appdelegate
            
            self.tableView.reloadData()  //29
           */
            
            self.saveItems()  //61 instead of the above made it into a function at the bottom
            }

        
        
        alert.addTextField { (alertTextField) in      //it knows the parameter type is that of textfield 26
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)  //24
        
     present(alert, animated: true, completion: nil)  //25
        
        
    }
    
    //MARK - Model Manipulation Methods
    
    func saveItems () {   //59
        let encoder = PropertyListEncoder()
        
        do {
            
            let data = try encoder.encode(itemArray)    //data is whatever was returned by the method encode i think. 56 
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems() {   //62
        if let data = try? Data(contentsOf: dataFilePath!) {
        let decoder = PropertyListDecoder()
        do {
        itemArray = try decoder.decode([Item].self, from: data)  //[Item].self because its referring to the type, not a specific object
        } catch {
            print("Error decoding item array, \(error)")
     }
    }
    
    
    
    }

}


