//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Bryan on 3/13/18.
//  Copyright © 2018 BK. All rights reserved.
//

import UIKit
import CoreData  //112

class CategoryViewController: UITableViewController {
    
    var categories = [Category]()  //113
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext //114

    override func viewDidLoad() {
        super.viewDidLoad()
        
    loadCategories()  //131
            

    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {  //115
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {//116
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name  //117
        
        return cell
    }
    
    //MARK: - Data Manipulation Methods
    
    func saveCategories() {    //128
        do {
        try context.save()
        } catch {
            print("Error saving category \(error)")
    }
        tableView.reloadData()
    }
        
    func loadCategories() {
        let request : NSFetchRequest<Category> = Category.fetchRequest()   //130
        
        do {
       categories = try context.fetch(request)
        } catch {
            print("Error loading categories \(error)")
        }
        tableView.reloadData()
        }
    
    //MARK: - Add New Categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()   //122
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert) //118
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in    //119
            
        let newCategory = Category(context: self.context)  //125
        newCategory.name = textField.text!    //126
        
        self.categories.append(newCategory)   //127
            
        self.saveCategories()  //129
            
        }
        
        alert.addAction(action)   //120
        
        alert.addTextField { (field) in    //121
        textField = field  //123
        textField.placeholder = "Add a new category"
        }
        
        present(alert, animated: true, completion: nil)    //124
        }
    }
    
    //MARK: - TableView Delegate Methods
    

