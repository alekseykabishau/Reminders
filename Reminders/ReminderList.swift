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
    
    func newReminder() -> Reminder {
        print(#function)
        let reminder = Reminder()
        reminder.name = randomTitle()
        reminders.append(reminder)
        return reminder
    }
    
    func move(item: Reminder, at index: Int) {
        print(#function)
        guard let currentIndex = reminders.firstIndex(of: item) else { return }
        reminders.remove(at: currentIndex)
        reminders.insert(item, at: index)
    }
    
    func remove(items: [Reminder]) {
        print(#function)
        for item in items {
            if let index = reminders.firstIndex(of: item) {
                reminders.remove(at: index)
            }
        }
    }
    
    private func randomTitle() -> String {
        let titles = ["New Reminder 1", "New Reminder 2", "New Reminder 3", "New Reminder 4", "New Reminder 5", "New Reminder 6"]
        let randomNumber = Int.random(in: 0...titles.count - 1)
        return titles[randomNumber]
    }
}
