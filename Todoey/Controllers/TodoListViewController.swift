//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    
    var itemArray : [Item] = []
    
    let defaults = UserDefaults.standard
    
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var newItem = Item()
        newItem.title = "Dance"
        itemArray.append(newItem)
        
        var newItem2 = Item()
        newItem2.title = "Sing"
        itemArray.append(newItem2)
        
        var newItem3 = Item()
        newItem3.title = "Talk"
        itemArray.append(newItem3)
        
//        if let item = defaults.array(forKey: "TodoListArray") as? [Item]{
//            itemArray = item
//        }
        
    }
    
    
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        
        //Value = Condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row].title)
        
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        self.saveItems()
        
        tableView.reloadData()
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    //MARK: - Add New Item
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add an Item to the List", message: "", preferredStyle: .alert)
        
        
        let action = UIAlertAction(title: "Add Item", style: .default ){ (action) in
            
            var newItem = Item()
            
            newItem.title = textfield.text!
            
            self.itemArray.append(newItem)
            
            
            self.saveItems()
            
            
//            self.defaults.set(self.itemArray, forKey: "TodoListArray")  // This was for UserDefaults
            
            self.tableView.reloadData()
            
        }
        
        alert.addTextField{ (alertTextField) in
            
            alertTextField.placeholder = "Add Item Here"
            textfield = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true)
        
        
    }
    
    
    func saveItems(){
        let encoder = PropertyListEncoder()
        
        do{
            
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }catch{
            
            print("Error Encoding \(error)")
            
        }
    }
    

}

