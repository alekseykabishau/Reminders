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
