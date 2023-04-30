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
    
    // hardcode stuff
    var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]
                     

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

// MARK: - TABLEVIEW DATASOURCE
    
    // Return the number of rows for the table. Copy Paste TableViewDataSource Protocol from apple docs
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    // Provide a cell object for each row.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier , for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
    
           
       return cell
    }
    
    // MARK: - TableView DELEGATE METHODS
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // print(itemArray[indexPath.row])
        let hasAccesory = tableView.cellForRow(at: indexPath)?.accessoryType
        if hasAccesory == UITableViewCell.AccessoryType.none {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none

        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Add New Items
    
    @IBAction func addItemPressed(_ sender: UIBarItem) {

        var textField = UITextField()
        // set up the alert and its action
        let alert = UIAlertController(title: "Add new to do", message: "", preferredStyle: .alert)
        // this action has a handler so a delegate ?
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once the user clicks Add Item in Alert
            self.itemArray.append(textField.text ?? "big empty")
            self.tableView.reloadData()
            
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
    
}

