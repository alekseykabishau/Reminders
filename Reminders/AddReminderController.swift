//
//  AddReminderController.swift
//  Reminders
//
//  Created by Aleksey on 0105..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import UIKit

class AddReminderController: UITableViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        print(#function)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        print(#function)
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Add Reminder"
        
        textField.delegate = self
        
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

extension AddReminderController: UITextFieldDelegate {
    
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
