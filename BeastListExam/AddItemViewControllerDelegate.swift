//
//  AddItemViewControllerDelegate.swift
//  BeastListExam
//
//  Created by Admin on 11/19/17.
//  Copyright © 2017 Jason Lee. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate : class {
    
    func AddItemViewController(sender: UIViewController, AddEntry text: String)
    
    func AddItemViewController(sender: UIViewController, EditEntry beast: Beast)
    
    func AddItemViewController(sender: UIViewController)
}

