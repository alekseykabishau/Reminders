//
//  ViewController.swift
//  Reminders
//
//  Created by Aleksey on 0101..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import UIKit

class RemindersViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderCell", for: indexPath)
        return cell
    }
}

