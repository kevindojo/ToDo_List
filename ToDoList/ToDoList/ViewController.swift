//
//  ViewController.swift
//  ToDoList
//
//  Created by Kevin Pham on 11/14/17.
//  Copyright © 2017 Kevin Pham. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController {
    
    var tableData: [ToDoItem] = []
    @IBOutlet weak var tableView: UITableView!
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let delegate = (UIApplication.shared.delegate as! AppDelegate)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableData = getItems()
        // access core data
        
        tableView.reloadData()
        //reload the "ToDoCell.swift(tableView)" file and its data
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //==== SEGUE ==== // add button -> present modally to next view/table controller
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItemSegue" {
            
            let dest = segue.destination as! UINavigationController
            let AddItem = dest.topViewController as! AddItemVC

            AddItem.delegate = self
        }
    }
    //==== SEGUE ==== //
    
    
    
    
    // ======== CORE DATA =============//
    
    func getItems() -> [ToDoItem] {
        do {
            
            let itemRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"ToDoItem")
            
            let results = try managedObjectContext.fetch(itemRequest)
            return results as! [ToDoItem]
            
        } catch {
            print("\(error)")
        }
        return []
    }
    
    // ======== CORE DATA =============//
}




extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    //how many cells are we going to need?! -> always needed
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    //how should we create each cell?! -> always needed
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell") as! ToDoCell
        let toDoItem = tableData[indexPath.row]
        
        cell.titleLabel.text = toDoItem.title
        
        let date = toDoItem.date!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM dd, yyyy"
        let dateStr = dateFormatter.string(from: date)
        
        cell.dateLabel.text = dateStr
        cell.descLabel.text = toDoItem.desc
        
        if toDoItem.complete {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    //modified the height of the custom cell
    func tableView(_ tableView: UITableView,heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    //what do I do when I'm clicked?!
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableData[indexPath.row].complete {
            tableData[indexPath.row].complete = false
        } else {
            tableData[indexPath.row].complete = true
        }
        delegate.saveContext()
        tableView.reloadData()
    }
}



extension ViewController: AddItemDelegate {
    
    // add to the database!
    func addItem(_ title: String, _ desc: String, _ date: Date, sender: UIViewController){
    
        let item = NSEntityDescription.insertNewObject(forEntityName: "ToDoItem", into: managedObjectContext) as! ToDoItem
        item.title = title
        item.desc = desc
        item.date = date
        
        tableData.append(item)
        
        delegate.saveContext()
        tableView.reloadData()
        sender.dismiss(animated: true, completion: nil)
        
    }
    
    func CancelButtonPressed(by controller: AddItemVC) {
        dismiss(animated: true, completion: nil)
    }
    
}
