//
//  ViewController.swift
//  ToDoList
//
//  Created by Kevin Pham on 11/14/17.
//  Copyright © 2017 Kevin Pham. All rights reserved.
//

import UIKit
import CoreData // step 3

class ViewController: UIViewController {
    
    //3c
    var tableData: [ToDoItem] = []
    
    @IBOutlet weak var tableView: UITableView!
    // ====== assign as "delegate" and "dataSource" ====== //
            // drag Table View to viewController//
    
    
    // 3a -> jump down to extension AddItemDelegate
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let delegate = (UIApplication.shared.delegate as! AppDelegate)
    //3a
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //3c
        tableData = getItems()
        // access core data
        
        //3d
        tableView.reloadData()
        //reload the "ToDoCell.swift(tableView)" file and its data
        //======= exists only after making "@IBOutlet weak var tableView" connection =========//
        
        // 3d ---> CREATE extension TableViewDelegate
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //==== SEGUE ==== // add button -> present modally to next view/table controller
    
    // step 5, set identifier in storyboard and CREATE FUNC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItemSegue" {
            
            let dest = segue.destination as! UINavigationController
            let AddItem = dest.topViewController as! AddItemVC

            AddItem.delegate = self
        }
    }// step 5 -> jump to extension AddItemDelegate
    
    
    //==== SEGUE ==== //
    
    
    
    
    // ======== CORE DATA =============//
    
    //3c
    func getItems() -> [ToDoItem] {
        do {
            
            // important line
            let itemRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"ToDoItem")
            
            let results = try managedObjectContext.fetch(itemRequest)
            return results as! [ToDoItem]
            
        } catch {
            print("\(error)")
        }
        return []
    }
    //3c -> create var [], update viewDidLoad
    
    // ======== CORE DATA =============//
    
    
} //end of class



// step 4 CREATE extension
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    // 4a
    //how many cells are we going to need?! -> ALWAYS needed ****
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    //how should we create each cell?! -> ALWAYS needed *****
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //4a -> CREATE prepare for FUNC SEGUE
        
        // step 7
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell") as! ToDoCell
        let toDoItem = tableData[indexPath.row]
        
        cell.titleLabel.text = toDoItem.title
        
        let date = toDoItem.date!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy hh:mm"
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
        
    } // step 7 -> end.
    
} // end of extension



//3b
extension ViewController: AddItemDelegate {
    
    // add to the database!
    func addItem(_ title: String, _ desc: String, _ date: Date, sender: UIViewController){
        
//3b -> after jump to CORE DATA FUNC
        
        // 5b
                        // calls database
        let item = NSEntityDescription.insertNewObject(forEntityName: "ToDoItem", into: managedObjectContext) as! ToDoItem
        item.title = title
        item.desc = desc
        item.date = date
        
        tableData.append(item)
        
        delegate.saveContext()
        tableView.reloadData()
        sender.dismiss(animated: true, completion: nil)
        
        //5b --> CREATE ToDoCell.swift file
        }
    
    
    
    
    
    // cancel and go back to tableView
    func CancelButtonPressed(by controller: AddItemVC) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // swipe to remove item
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let item = tableData[indexPath.row]
        managedObjectContext.delete(item)
        do {
            try managedObjectContext.save()
        } catch {
            print ("\(error)")
        }
        tableData.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
} //end of extension
