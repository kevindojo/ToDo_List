//
//  AddItemDelegate.swift
//  ToDoList
//
//  Created by Kevin Pham on 11/14/17.
//  Copyright © 2017 Kevin Pham. All rights reserved.
//

import UIKit

// step 2
protocol AddItemDelegate: class {
    
    func addItem(_ title: String, _ desc: String, _ date: Date, sender: UIViewController)
    
    func CancelButtonPressed (by controller: AddItemVC)
}
// step 2 -> jump to ViewController

