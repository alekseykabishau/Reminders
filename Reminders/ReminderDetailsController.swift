//
//  ReminderDetailsController.swift
//  Reminders
//
//  Created by Aleksey on 0105..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import UIKit

protocol ReminderDetailsControllerDelegate: class {
    func reminderDetailsControllerDidCancel(_ viewController: ReminderDetailsController)
    func reminderDetailsController(_ viewController: ReminderDetailsController, didFinishAdding item: Reminder)
    func reminderDetailsController(_ viewController: ReminderDetailsController, didFinishEditing item: Reminder)
}

class ReminderDetailsController: UITableViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    weak var delegate: ReminderDetailsControllerDelegate?
    weak var reminderList: ReminderList?
    weak var reminderToEdit: Reminder?
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        print(#function)
        delegate?.reminderDetailsControllerDidCancel(self)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        print(#function)
        
        if let reminderToEdit = reminderToEdit {
            if let text = textField.text {
                reminderToEdit.name = text
                delegate?.reminderDetailsController(self, didFinishEditing: reminderToEdit)
            }
        } else {
            if let reminder = reminderList?.newReminder() {
                if let text = textField.text {
                    reminder.name = text
                    reminder.checked = false
                }
                delegate?.reminderDetailsController(self, didFinishAdding: reminder)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        textField.delegate = self
        
        // if there is an reminder to edit - it's editing mode
        if let reminderToEdit = reminderToEdit {
            navigationItem.title = "Update Reminder"
            textField.text = reminderToEdit.name
        } else {
            navigationItem.title = "Add Reminder"
            
        }
    }
    
    // in order to show keyboard right away and put cursor into text field
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    // if don't want the cell to be highlighted as selected == tableViewCell.selection.none
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}

extension ReminderDetailsController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print(#function)
        return false // what is the difference here
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(#function)
        guard let oldText = textField.text,
            let stringRange = Range(range, in: oldText) else {
            return false
        }
        
        // covers pasting text by user scenerio
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        if newText.isEmpty {
            saveButton.isEnabled = false
        } else {
            saveButton.isEnabled = true
        }

        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(#function)
    }
}
