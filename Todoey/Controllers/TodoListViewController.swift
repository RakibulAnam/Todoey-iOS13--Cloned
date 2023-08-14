//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var itemArray : [Item] = []
    
    //let defaults = UserDefaults.standard
    
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  loadItem()
        
//        if let item = defaults.array(forKey: "TodoListArray") as? [Item]{
//            itemArray = item
//        }
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
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
        print(itemArray[indexPath.row].title!)
        
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        self.saveItems()
        
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    //MARK: - Add New Item
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add an Item to the List", message: "", preferredStyle: .alert)
        
        
        let action = UIAlertAction(title: "Add Item", style: .default ){ (action) in
            
            let newItem = Item(context: self.context)
            newItem.done = false
            
            newItem.title = textfield.text!
            
            self.itemArray.append(newItem)
            
            
            self.saveItems()
            
            
//            self.defaults.set(self.itemArray, forKey: "TodoListArray")  // This was for UserDefaults
            
            
            
        }
        
        alert.addTextField{ (alertTextField) in
            
            alertTextField.placeholder = "Add Item Here"
            textfield = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true)
        
        
    }
    
    
    func saveItems(){
        
        
        do{
           try context.save()
            
        }catch{
            
          print("The Error is \(error)")
            
        }
        
        tableView.reloadData()
        
    }
    
//    func loadItem(){
//
//        if let data  = try? Data(contentsOf: dataFilePath!){
//
//            let decoder = PropertyListDecoder()
//            do{
//                itemArray = try decoder.decode([Item].self, from: data)
//            }catch{
//                print("Error Decoding data \(error)")
//            }
//
//        }
//
//    }
    

}

