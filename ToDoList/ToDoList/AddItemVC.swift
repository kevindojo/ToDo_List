//
//  AddItemVC.swift
//  ToDoList
//
//  Created by Kevin Pham on 11/14/17.
//  Copyright © 2017 Kevin Pham. All rights reserved.
//

import UIKit

class AddItemVC: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var descArea: UITextView!
    @IBOutlet weak var date: UIDatePicker!
    
    weak var delegate: AddItemDelegate?
    
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
        let title = titleLabel.text!
        let desc = descArea.text!
        let d = date.date
        
        if title != " " && desc != " " {
            delegate?.addItem(title, desc, d, sender: self)
        }
    }
    
} // end of class



