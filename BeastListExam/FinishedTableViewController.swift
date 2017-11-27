//
//  FinishedTableViewController.swift
//  BeastListExam
//
//  Created by Admin on 11/19/17.
//  Copyright © 2017 Jason Lee. All rights reserved.
//

import UIKit
import CoreData

class FinishedTableViewController: UITableViewController {
    
    var beasts = [Beast]()
    
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.dateFormat = "EEE MMM yy"
        fetchAllEntries()
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated : Bool) {
        fetchAllEntries()
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beasts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FinishedCell", for: indexPath) as! FinishedCell
        cell.beastLabel.text = beasts[indexPath.row].text
        cell.dateLabel.text = "\(formatter.string(from: beasts[indexPath.row].date as! Date))"
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        deleteBeast(beast: beasts[indexPath.row])
        beasts.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    func fetchAllEntries(){
        do {
            let results = try context.fetch(Beast.fetchRequest())
            let Entries = results as! [Beast]
            beasts = Entries.filter({ beast in
                return (beast.completed)
            })
        } catch {
            print("\(error)")
        }
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("\(error)")
            }
        }
    }
    
    func deleteBeast(beast: Beast){
        self.context.delete(beast)
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("\(error)")
            }
        }
    }
}
