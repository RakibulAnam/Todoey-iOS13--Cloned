//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController{

    
    
    let realm = try! Realm()
    
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var itemArray : Results<Item>?
    
    var selectedCategory : Category?{
        
        didSet{
            loadItem()
        }
        
    }
    
    //let defaults = UserDefaults.standard
    
    
   // let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        if let item = defaults.array(forKey: "TodoListArray") as? [Item]{
//            itemArray = item
//        }
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
    }
    
    
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray?.count ?? 1
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = itemArray?[indexPath.row]{
            cell.textLabel?.text = item.title
            //Value = Condition ? valueIfTrue : valueIfFalse
            cell.accessoryType = item.done ? .checkmark : .none
        }
        else{
            cell.textLabel?.text = "No items Added"
        }
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        
        if let item = itemArray?[indexPath.row]{
            
            do{
                
               try realm.write{
                   
                   /*
                    to delete
                    realm.delete(item)
                    */
                    item.done = !item.done
                }
                
            }catch{
                print("Problem Updating \(error)")
            }
            
            tableView.reloadData()
            
        }
        
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    //MARK: - Add New Item
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add an Item to the List", message: "", preferredStyle: .alert)
        
        
        let action = UIAlertAction(title: "Add Item", style: .default ){ (action) in
            
            
            
//            self.defaults.set(self.itemArray, forKey: "TodoListArray")  // This was for UserDefaults
            
            
            if let currentCategory = self.selectedCategory{
            
                do{
                    try self.realm.write{
                        
                        let newItem = Item()
                        newItem.title = textfield.text!
                        
                        currentCategory.items.append(newItem)
                    }
                }catch{
                    print("Error Saving Item \(error)")
                }
                
            }
            
            self.tableView.reloadData()
             
        }
        
     
        
        
        
        
        
        alert.addTextField{ (alertTextField) in
            
            alertTextField.placeholder = "Add Item Here"
            textfield = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true)
        
        
    }
    
    

    
    func loadItem(){

        itemArray = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
       
        tableView.reloadData()

    }
    
//    func deleteItem(indexPath : IndexPath){
//
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
//
//    }
    
   
    

}

//MARK: - SearchBar Pattern

extension TodoListViewController : UISearchBarDelegate{
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
   
        
        itemArray = itemArray?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItem()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }


        }


    }
    
}

