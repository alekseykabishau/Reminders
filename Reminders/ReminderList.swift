//
//  ReminderList.swift
//  Reminders
//
//  Created by Aleksey on 0103..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import Foundation

class ReminderList {
    
    var reminders: [Reminder] = []
    
    init() {
        let reminder1 = Reminder()
        let reminder2 = Reminder()
        let reminder3 = Reminder()
        let reminder4 = Reminder()
        let reminder5 = Reminder()
        
        reminder1.name = "Take a Jog"
        reminder2.name = "Watch a movie"
        reminder3.name = "Code an App"
        reminder4.name = "Walk the dog"
        reminder5.name = "Study design"
        
        reminders.append(reminder1)
        reminders.append(reminder2)
        reminders.append(reminder3)
        reminders.append(reminder4)
        reminders.append(reminder5)
    }
}
