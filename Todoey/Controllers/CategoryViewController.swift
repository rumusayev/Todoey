//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Ruslan on 1/16/18.
//  Copyright © 2018 Ruslan M. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categoyArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        
        print( FileManager.default.urls(for: .documentDirectory, in: .userDomainMask) )
    }
    
    //MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoyArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let item = categoyArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVS = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVS.selectedCategory = categoyArray[indexPath.row]
        }
        
    }
    
    
    //MARK: - Data Manipulation Methods
    
    func saveCategory(){
        
        do {
            try context.save()
        } catch {
            print("Error on saving category")
        }
        
        tableView.reloadData()
    }
    
    
    //MARK: - Add NEW Category
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            newCategory.title = textField.text
            
            self.categoyArray.append(newCategory)
            
            self.saveCategory()
        }

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Category"
            
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func loadData(with request : NSFetchRequest<Category> = Category.fetchRequest()){
        
        do {
            categoyArray = try context.fetch(request)
        } catch {
            print("Error while fetching")
        }
        
        tableView.reloadData()
        
    }
}
