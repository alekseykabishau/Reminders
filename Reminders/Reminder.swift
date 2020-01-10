//
//  Reminder.swift
//  Reminders
//
//  Created by Aleksey on 0103..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import Foundation

class Reminder: NSObject {
    var name = ""
    var checked = false
    
    // model should handle its own state, not VC
    func toggleChecked() {
        checked.toggle()
    }
}
