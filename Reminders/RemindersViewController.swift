//
//  ViewController.swift
//  Reminders
//
//  Created by Aleksey on 0101..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import UIKit

class RemindersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var reminderList: ReminderList
    
    @IBAction func addItem(_ sender: Any) {
        
    }
    // called when VC is initialized from storyboard
    required init?(coder: NSCoder) {
        reminderList = ReminderList()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Reminders"
        //navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
    }
    
    @objc func addItem() {
        print(#function)
        let arrayCount = reminderList.reminders.count
        _ = reminderList.newReminder()
        let indexPath = IndexPath(row: arrayCount, section: 0)
        tableView.insertRows(at: [indexPath], with: .left)
        //tableView.reloadData()
    }
    
    func configureCheckmark(for cell: UITableViewCell, with reminder: Reminder) {
        if reminder.checked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
    
    func configureText(for cell: UITableViewCell, with reminder: Reminder) {
        if let label = cell.viewWithTag(1000) as? UILabel {
            label.text = reminder.name
        }
    }
}

extension RemindersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let reminder = reminderList.reminders[indexPath.row]
        reminder.toggleChecked() // model's method
        if let cell = tableView.cellForRow(at: indexPath) {
            configureCheckmark(for: cell, with: reminder)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print(#function)
        reminderList.reminders.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddReminderSegue" {
            if let addReminderViewController = segue.destination as? AddReminderController {
                addReminderViewController.delegate = self
            }
        }
    }
}

extension RemindersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminderList.reminders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderCell", for: indexPath)
        let reminder = reminderList.reminders[indexPath.row]
        configureText(for: cell, with: reminder)
        configureCheckmark(for: cell, with: reminder)
        
        return cell
    }
}

extension RemindersViewController: AddReminderControllerDelegate {
    func addReminderControllerDidCancel(_ viewController: AddReminderController) {
        print(#function)
        navigationController?.popViewController(animated: true)
    }
    
    func addReminderController(_ viewController: AddReminderController, didFinishAdding item: Reminder) {
        print(#function)
        navigationController?.popViewController(animated: true)
        
        let rowIndex = reminderList.reminders.count
        reminderList.reminders.append(item)
        let indexPath = IndexPath(row: rowIndex, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    
}
