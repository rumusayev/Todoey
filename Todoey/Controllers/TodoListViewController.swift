//
//  ViewController.swift
//  Todoey
//
//  Created by Ruslan on 1/10/18.
//  Copyright © 2018 Ruslan M. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [TodoItem]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let newItem = TodoItem()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = TodoItem()
        newItem2.title = "Find Ruslan"
        newItem2.done = true
        itemArray.append(newItem2)
        
        let newItem3 = TodoItem()
        newItem3.title = "Find Yavar"
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "TodoListArray") as? [TodoItem] {
            itemArray = items
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            if textField.text?.isEmpty == false {
                
                let newItem = TodoItem()
                newItem.title = textField.text!
                
                self.itemArray.append(newItem)
                
                self.defaults.setValue(self.itemArray, forKey: "TodoListArray")
                
                self.tableView.reloadData()
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
}

