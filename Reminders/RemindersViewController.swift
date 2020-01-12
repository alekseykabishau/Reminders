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
    
    // called when VC is initialized from storyboard
    required init?(coder: NSCoder) {
        reminderList = ReminderList()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelectionDuringEditing = true
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Reminders"
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        tableView.setEditing(isEditing, animated: true)
        if isEditing {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deleteSelected))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        }
    }
    
    @objc func deleteSelected() {
        print(#function)
        if let indexPaths = tableView.indexPathsForSelectedRows {
            var selectedReminders = [Reminder]()
            for indexPath in indexPaths {
                selectedReminders.append(reminderList.reminders[indexPath.row])
            }
            reminderList.remove(items: selectedReminders)
            // batch updates of table view
            tableView.beginUpdates()
            tableView.deleteRows(at: indexPaths, with: .automatic)
            tableView.endUpdates()
        }
    }
    
    @objc func addItem() {
        print(#function)
        // TODO: call prepare for segue with identifier + changes in storyboard
        performSegue(withIdentifier: "AddReminderSegue", sender: self)
    }
    
    func configureCheckmark(for cell: ReminderCell, with reminder: Reminder) {
        if reminder.checked {
            cell.checkmarkLabel.text = "√"
        } else {
            cell.checkmarkLabel.text = ""
        }
    }
    
    func configureText(for cell: ReminderCell, with reminder: Reminder) {
        cell.titleLabel.text = reminder.name

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddReminderSegue" {
            if let addReminderViewController = segue.destination as? ReminderDetailsController {
                addReminderViewController.delegate = self
                addReminderViewController.reminderList = reminderList
            }
        } else if segue.identifier == "EditReminderSegue" {
            if let addReminderViewController = segue.destination as? ReminderDetailsController {
                //getting the item from the sender which is table view cell
                if let cell = sender as? UITableViewCell {
                    if let indexPath = tableView.indexPath(for: cell) {
                        let reminder = reminderList.reminders[indexPath.row]
                        addReminderViewController.reminderToEdit = reminder
                        addReminderViewController.delegate = self
                    }
                }
            }
        }
    }
}

extension RemindersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !tableView.isEditing {
            let reminder = reminderList.reminders[indexPath.row]
            reminder.toggleChecked() // model's method
            if let cell = tableView.cellForRow(at: indexPath) as? ReminderCell {
                configureCheckmark(for: cell, with: reminder)
            }
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print(#function)
        reminderList.reminders.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print(#function)
        reminderList.move(item: reminderList.reminders[sourceIndexPath.row], at: destinationIndexPath.row)
    }
}

extension RemindersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminderList.reminders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderCell", for: indexPath) as! ReminderCell
        let reminder = reminderList.reminders[indexPath.row]
        configureText(for: cell, with: reminder)
        configureCheckmark(for: cell, with: reminder)
        return cell
    }
}

extension RemindersViewController: ReminderDetailsControllerDelegate {
    
    func reminderDetailsControllerDidCancel(_ viewController: ReminderDetailsController) {
        print(#function)
        navigationController?.popViewController(animated: true)
    }
    
    func reminderDetailsController(_ viewController: ReminderDetailsController, didFinishAdding item: Reminder) {
        print(#function)
        navigationController?.popViewController(animated: true)
        
        let rowIndex = reminderList.reminders.count - 1
        //reminderList.reminders.append(item)
        let indexPath = IndexPath(row: rowIndex, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func reminderDetailsController(_ viewController: ReminderDetailsController, didFinishEditing item: Reminder) {
        print(#function)
        navigationController?.popViewController(animated: true)
        
        if let index = reminderList.reminders.firstIndex(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) as? ReminderCell {
                configureText(for: cell, with: item)
            }
        }
    }
}
