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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let borderColor: UIColor = UIColor(displayP3Red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        descArea.layer.borderWidth = 1.0
        descArea.layer.borderColor = borderColor.cgColor
        descArea.layer.cornerRadius = 5.0
    }
    
} // end of class



