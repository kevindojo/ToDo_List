//
//  AddItemVC.swift
//  ToDoList
//
//  Created by Kevin Pham on 11/14/17.
//  Copyright © 2017 Kevin Pham. All rights reserved.
//

// STEP 1 after storyboard layout and connections //

import UIKit

class AddItemVC: UIViewController {
    
    // 1a
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var descArea: UITextView!
    @IBOutlet weak var date: UIDatePicker!
    
    // 1b -> make AddItemDelegate.swift file
    weak var delegate: AddItemDelegate?
    

    // 1a
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
        let title = titleLabel.text!
        let desc = descArea.text!
        let d = date.date
        
        if title != " " && desc != " " {
            delegate?.addItem(title, desc, d, sender: self)
        }
    } //1a
    
    
    
    
    

    @IBAction func CancelButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.CancelButtonPressed(by:self)
        
    }
    
    
    
    
    
    //extra
    override func viewDidLoad() {
        super.viewDidLoad()
        //adds border to specified area
        let borderColor: UIColor = UIColor(displayP3Red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        descArea.layer.borderWidth = 1.0
        descArea.layer.borderColor = borderColor.cgColor
        descArea.layer.cornerRadius = 5.0
        
        date.layer.borderWidth = 1.0
        date.layer.borderColor = borderColor.cgColor
        date.layer.cornerRadius = 5.0
    }
    
} // end of class



