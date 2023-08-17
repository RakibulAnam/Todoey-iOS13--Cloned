//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Jotno on 8/16/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var categoryArray : [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        loadCategory()
        
    }
    
    

    
    
    
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        return cell
        
    }
    
    
    
    //MARK: - Delegate Methods
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
        
    }
    
    
    //MARK: - Data Manipulation Method
    
    
    func saveCategory(){
        
        do{
            try context.save()
        }catch{
            print("Error saving Category \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    func loadCategory(){
        
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do{
            categoryArray = try context.fetch(request)
        }catch{
            print("Couldn't Get The Data \(error)")
        }
        
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
            let newCategory = Category(context: self.context)

            newCategory.name = textField.text!
            
            self.categoryArray.append(newCategory)
            
            self.saveCategory()
            
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true)
        
        
        
    }
    

}
