//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Ruslan on 1/16/18.
//  Copyright © 2018 Ruslan M. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()

   var categoyArray: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
      
        print( FileManager.default.urls(for: .documentDirectory, in: .userDomainMask) )
    }
    
    //MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoyArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categoyArray?[indexPath.row].title ?? "No Categories Added Yet"
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVS = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVS.selectedCategory = categoyArray?[indexPath.row]
        }
        
    }
    
    
    //MARK: - Data Manipulation Methods
    
    func saveCategory(category: Category){
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error on saving category")
        }
        
        tableView.reloadData()
    }
    
    
    //MARK: - Add NEW Category
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.title = textField.text!
            
            self.saveCategory(category: newCategory)
        }

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Category"
            
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func loadData(){

        categoyArray = realm.objects(Category.self)

        tableView.reloadData()

    }
}
