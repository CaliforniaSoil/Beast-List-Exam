//
//  AddItemViewController.swift
//  BeastListExam
//
//  Created by Admin on 11/19/17.
//  Copyright © 2017 Jason Lee. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {
    
    weak var delegate : BeastListTableViewController?
    
    var editEntry : Beast?

    @IBOutlet weak var beastTextField: UITextField!
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        if editEntry == nil {
            let text = beastTextField.text
            delegate!.AddItemViewController(sender: self, AddEntry: text!)
        } else {
            editEntry?.text = beastTextField.text
            delegate!.AddItemViewController(sender: self, EditEntry: editEntry!)
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        delegate!.AddItemViewController(sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if editEntry != nil {
            beastTextField.text = editEntry?.text
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
