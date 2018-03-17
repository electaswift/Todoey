//
//  ViewController.swift
//  Todoey
//
//  Created by Bryan on 3/7/18.
//  Copyright © 2018 BK. All rights reserved.
//

import UIKit
import CoreData  //85

class ToDoListViewController: UITableViewController {             //5. 6 is to change name of this vc to "ToDoListViewController"  7 is on notes. 94. 95 is on notes



    //var itemArray = ["Do Drugs", "Smoke Weed", "Take a shit"]    //11
    var itemArray = [Item]() //array of item objects  36
    
    //var selectedCategory : Category? { //135 everything in between didSet will trigger once it has a value
    var selectedCategory : Category2? {    //174
    didSet{
       // loadItems()
    }  
    }
    
   // let defaults = UserDefaults.standard   //30
    
   //   let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist") //54
    
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext   //82 we need to call appdelegate.persistentcontainer.viewcontext but appdelegate is a class, not an object. so to get the object we need to use singleton object. shared UI application refers to live application object. the AppDelegate is the singleton object's delegate.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")) //87 run this so you can see the file general area. users/bryan/Library/Developer/CoreSimulator/Devices/F6/data/Containers/Data/Application/20E/Library/Application Support/ DataModel.sqlite.  88 is on notes

    /*let newItem = Item()    //35
        newItem.title = "Find Mike"
        itemArray.append(newItem) //37
        
        let newItem2 = Item()    //38
        newItem2.title = "Buy Eggos"
        itemArray.append(newItem2)
        
        let newItem3 = Item()    //39
        newItem3.title = "Destroy Demogorgon"
        itemArray.append(newItem3) */
        
      // loadItems()  //63 take the above out. 64 on item class   //90
        
        
        
     // if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {   //33 using if let cause if defaults.array has no key todolistarray, then app crashes.  34 is creating a new class. file new file, new swift file.    53 is uncommenting this code out.  the app will crash cause we are trying to user userdefaults by putting in our own custom made objects in an array as the value which is beyonod the scope of user defaults.
    //  itemArray = items
  //    }
    }
    
    //MARK: - Tableview Datasource Methods
    
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
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        //  context.delete(itemArray[indexPath.row])  //91   need this step so it removes it from context object and not just our object array
      //  itemArray.remove(at: indexPath.row)    //92   these two used if you want to delete items. rmbr that the order matters. 93 is on notes
      
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
    
    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {  //20
        
        var textField = UITextField()     //27
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert) //22
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in   //23
           // print("Success") 23
         
            //self.itemArray.append(textField.text!)   //28
            
           // let newItem = Item()      //41
            
         /*   let newItem = Item(context: self.context)    //83
            newItem.title = textField.text!   //42
            newItem.done = false //86 this is nec cause our coredata attribute of bool is not optional. so it will crash if you dont have this
            newItem.parentCategory = self.selectedCategory      //136
            
            //self.itemArray.append(textField.text!)
            self.itemArray.append(newItem)  //43  */
            
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
             textField = alertTextField
            alertTextField.placeholder = "Create New Item"
           
            
        }
        
        alert.addAction(action)  //24
        
     present(alert, animated: true, completion: nil)  //25
        
        
    }
    

    //MARK: - Model Manipulation Methods
    
    func saveItems () {   //59
       // let encoder = PropertyListEncoder()
        
        do {

           try context.save()  //84
            
          //  let data = try encoder.encode(itemArray)    //data is whatever was returned by the method encode i think. 56
          //  try data.write(to: dataFilePath!)
        } catch {
            print("Error saving context \(error)")
          //  print("Error encoding item array, \(error)")
        }
        
        self.tableView.reloadData()
    }
    
  /*  func loadItems() {   //62
        if let data = try? Data(contentsOf: dataFilePath!) {
        let decoder = PropertyListDecoder()
        do {
        itemArray = try decoder.decode([Item].self, from: data)  //[Item].self because its referring to the type, not a specific object
        } catch {
            print("Error decoding item array, \(error)")
     }
    }

    } */
    
  /*  func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {    //89, 138 add predicate parameter, 143
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)  //136 within the fetchrequest, does the parentcategory.name match the selectedcategory.name
        
        if let additionalPredicate = predicate {  //142   if the predicate from searchbarbuttonclicked load has a value, then make it equal to additionalpredicate and use it below
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate]) //compound predicates return an array of both of those predicate searches
        } else {
            request.predicate = categoryPredicate
        }
        
       // let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate])   //140
        
       // request.predicate = compoundPredicate  //137, 141
        
        do {
           itemArray = try context.fetch(request)     //telling the intermediary context to go fetch request, which is to open up item object and fetch
        } catch {
            print("Failed to fetch request")
        }
        
        tableView.reloadData()
   
    } */
    

}

/* extension ToDoListViewController: UISearchBarDelegate {  //96, 97 this is a way to split the vc according to diff functionalities
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {  //98
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)      //144
        
     //  request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)  //the cd makes it insensitive to some diacretic sensitive shit  98
        
       request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]  //will return all item objects that have title key.  98
        
     //   request.sortDescriptors = [sortDescriptor]   //can take in multiple rules of sortdescriptors in an array but in this case, we only have one rule. to sort by title
        
        //loadItems(with: request, predicate: predicate)   //139
        loadItems(with: request, predicate: predicate)  //145. 146 on notes
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {    //99. 100 is on notes
        if searchBar.text?.count == 0 {
        loadItems()
           
            DispatchQueue.main.async {       //the shit that decides priorities. telling it to go to main and do this code in the main
                 searchBar.resignFirstResponder()   //go to the original state you were in before you were activated
            }
        }
    }
 
    
 } */











