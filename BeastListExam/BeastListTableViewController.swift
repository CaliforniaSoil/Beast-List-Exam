//
//  BeastListTableViewController.swift
//  BeastListExam
//
//  Created by Admin on 11/19/17.
//  Copyright © 2017 Jason Lee. All rights reserved.
//

import UIKit
import CoreData

class BeastListTableViewController: UITableViewController, AddItemViewControllerDelegate, BeastListCellDelegate {
    let currentDate = NSDate()
    var beasts = [Beast]()
    
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "AddBeastSegue", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllEntries()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beasts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeastListCell", for: indexPath) as! BeastListCell
        cell.beastLabel.text = beasts[indexPath.row].text
        cell.delegate = self
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        performSegue(withIdentifier: "AddBeastSegue", sender: tableView.cellForRow(at: indexPath))
    }
    

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        deleteEntry(beast: beasts[indexPath.row])
        beasts.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    func fetchAllEntries(){
        do {
            let results = try context.fetch(Beast.fetchRequest())
            let unfilteredEntry = results as! [Beast]
            beasts = unfilteredEntry.filter({ beast in
                return !(beast.completed)
            })
        } catch {
            print("\(error)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddBeastSegue" {
            let navController = segue.destination as! UINavigationController
            let controller = navController.topViewController as! AddItemViewController
            controller.delegate = self
            
            if let cell = sender as? BeastListCell {
                let indexPath = tableView!.indexPath(for: cell)!
                controller.editEntry = beasts[(indexPath.row)]
            }
        } else {
            super.prepare(for: segue, sender: sender)
        }
        
    }
    
    func createEntry(text: String?, date: NSDate, completed: Bool){
        let entry = NSEntityDescription.insertNewObject(forEntityName: "Beast", into: self.context) as! Beast
        entry.text = text
        entry.date = date as Date
        entry.completed = completed
        if context.hasChanges {
            do {
                try context.save()
            } catch {
            }
        }
        tableView?.reloadData()
    }
    
    func deleteEntry(beast: Beast){
        self.context.delete(beast)
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("\(error)")
            }
        }
    }
    
    func AddItemViewController(sender: UIViewController, AddEntry text: String) {
        dismiss(animated: true, completion: nil)
        createEntry(text: text, date: currentDate, completed: false)
        fetchAllEntries()
        tableView.reloadData()
    }

    func AddItemViewController(sender: UIViewController, EditEntry beast: Beast){
        dismiss(animated: true, completion: nil)
        fetchAllEntries()
        tableView.reloadData()
    }
    
    func AddItemViewController(sender: UIViewController){
        dismiss(animated: true, completion: nil)
    }
    
    func beastButtonPressed(sender: UITableViewCell) {
        let index = tableView.indexPath(for: sender)?.row
        let beast = beasts[index!]
        beast.completed = true
        beast.date = currentDate as Date
        fetchAllEntries()
        tableView.reloadData()
    }
}

