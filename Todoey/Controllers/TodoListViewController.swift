//
//  ViewController.swift
//  Todoey
//
//  Created by Ruslan on 1/10/18.
//  Copyright © 2018 Ruslan M. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {

    var todoItems: Results<TodoItem>?
    
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet{
            loadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print( FileManager.default.urls(for: .documentDirectory, in: .userDomainMask) )
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [TodoItem] {
//            todoItems = items
//        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        if let todoItem = todoItems?[indexPath.row]{
            
            cell.textLabel?.text = todoItem.title
            
            cell.accessoryType = todoItem.done ? .checkmark : .none
        } else {
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                print("Error saving Done status \(error)")
            }
        }
        
        tableView.reloadData()
        
//        todoItems[indexPath.row].done = !todoItems[indexPath.row].done
//
//        saveTodoItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {

        var textField = UITextField()

        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)

        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            if let currentCategory = self.selectedCategory {
                
                do {
                    
                    try self.realm.write {
                        let newItem = TodoItem()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.todoItems.append(newItem)
                    }
                } catch {
                    print("Error while saving Todoe Item \(error)")
                }
                
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
    
    func saveTodoItems(todoItem: TodoItem) {
        
        do {
            try realm.write {
                realm.add(todoItem)
            }
        } catch {
            print("Error while saving Todoe Item \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadData(){
        
        todoItems = selectedCategory?.todoItems.sorted(byKeyPath: "title", ascending: true)

        tableView.reloadData()
    }
    
}

//MARK: - Search bar methods

extension TodoListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: false)
        
        tableView.reloadData()
        
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadData()

            DispatchQueue.main.async {

                searchBar.resignFirstResponder()
            }
        } else {

        }
    }
}


