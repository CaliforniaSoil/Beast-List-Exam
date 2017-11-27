//
//  BeastListCell.swift
//  BeastListExam
//
//  Created by Admin on 11/19/17.
//  Copyright © 2017 Jason Lee. All rights reserved.
//

import UIKit

class BeastListCell: UITableViewCell {
    
    weak var delegate : BeastListTableViewController?
    
    @IBOutlet weak var beastLabel: UILabel!
    
    @IBOutlet weak var beastButton: NSLayoutConstraint!
    
    @IBAction func beastButtonPressed(_ sender: UIButton) {
        delegate!.beastButtonPressed(sender: self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
