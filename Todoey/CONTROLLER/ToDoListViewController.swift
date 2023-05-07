//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//  https://github.com/appbrewery/Todoey-iOS13
//  @yannemal 30 APRIL 2023

import UIKit

class ToDoListViewController: UITableViewController {
    
    // an Array filled with type Item()
    var itemArray = [Item]()
    
    //    let defaults = UserDefaults.standard
    
    // set up NSCoder singleton
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in :
            .userDomainMask).first?
        .appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up NSCoder
        
        // print(dataFilePath)
        
//        let newItem = Item()
//        newItem.title = "Find Mike"
//        itemArray.append(newItem)
//        
//        
//        let newItem2 = Item()
//        newItem2.title = "Buy eggos"
//        itemArray.append(newItem2)
//        
//        
//        let newItem3 = Item()
//        newItem3.title = "Destroy Demorgon"
//        itemArray.append(newItem3)
        
        
        loadItems()
        
        
        //               if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
        //                    itemArray = items
        //         }
    }
    
    // MARK: - TABLEVIEW DATASOURCE METHODS
    
    // Return the number of rows for the table. Copy Paste TableViewDataSource Protocol from apple docs
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // Provide a cell object for each row.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier , for: indexPath)
        
        let item  = itemArray[indexPath.row]
        // cell.textLabel?.text = itemArray[indexPath.row].title
        cell.textLabel?.text = item.title
        
        
        cell.accessoryType = item.done ? .checkmark :  .none
        //        if item.done == true {
        //            cell.accessoryType = .checkmark
        //        } else {
        //            cell.accessoryType = .none
        //        }
        
        return cell
    }
    
    // MARK: - TableView DELEGATE METHODS
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        //        if itemArray[indexPath.row].done == false {
        //            itemArray[indexPath.row].done = true
        //        } else {
        //            itemArray[indexPath.row].done = false
        //        }
        saveItems()
        
        // tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    // MARK: - Add New Items
    
    @IBAction func addItemPressed(_ sender: UIBarItem) {
        
        var textField = UITextField()
        // set up the alert and its action
        let alert = UIAlertController(title: "Add new to do", message: "", preferredStyle: .alert)
        // this action has a handler so a delegate ?
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in // <- Closure!!
            // what will happen once the user clicks Add Item in Alert
            // create newItem using DataModel class
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            // self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            // create encoder for Plist
            self.saveItems()
        }
        // add a textfield for user input
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Write new to do"
            textField = alertTextField // extending the scope
            
        }
        // call and run alert and its action
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Model Manipulation Methods
    
    func saveItems() {
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
            
        } catch {
            print("error encoding item array,  \(error)")
        }
        
        
        self.tableView.reloadData()
        
        
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding from Item Plist, \(error)")
            }
        }
    }
}
