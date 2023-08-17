//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Jotno on 8/16/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class CategoryViewController: UITableViewController {

    
    
    
    let realm = try! Realm()
   // let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var categoryArray : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
       loadCategory()
        
    }
    
    

    
    
    
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categoryArray?[indexPath.row]
        
        cell.textLabel?.text = category?.name ?? "No categories Added"
        
        return cell
        
    }
    
    
    
    //MARK: - Delegate Methods
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
        
    }
    
    
    //MARK: - Data Manipulation Method
    
    
    func saveCategory(category : Category){
        
        do{
            try realm.write{
                realm.add(category)
            }
        }catch{
            print("Error saving Category \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    func loadCategory(){
        
       
        categoryArray = realm.objects(Category.self)
        
        
        tableView.reloadData()
        
        
        
    }
    
    
    
    
    
    

    //MARK: - Add New Cateory Methods
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: .alert)
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Enter Category"
            textField = alertTextField
        }
        
        let action = UIAlertAction(title: "Add", style: .default){ (action) in
            let newCategory = Category()

            newCategory.name = textField.text!
            
            self.saveCategory(category: newCategory)
            
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true)
        
        
        
    }
    

}
