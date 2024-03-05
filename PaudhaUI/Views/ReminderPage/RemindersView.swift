//
//  RemindersView.swift
//  PaudhaUI
//
//  Created by user1 on 13/02/24.
//


import SwiftUI

struct RemindersView: View {
    @ObservedObject var reminderStore = ReminderStore()
    @State private var isAddReminderSheetPresented = false

    var body: some View {
        NavigationView {
            List {
                Section(header: ReminderSummaryView(reminderStore: reminderStore)) {
                    ForEach(reminderStore.reminders) { reminder in
                        ReminderRowView(reminder: reminder)
                    }
                    .onDelete { indexSet in
                        reminderStore.deleteReminder(at: indexSet)
                    }
                }
            }
            .background( LinearGradient(gradient: Gradient(colors: [Color(red: 0.9686, green: 0.8824, blue: 0.8431), Color(red: 240/255.0, green: 255/255.0, blue: 241/255.0)]),
                                         startPoint: .topLeading,
                                         endPoint: .bottomTrailing
                                     ))
            .scrollContentBackground(.hidden)
            .navigationBarTitle("Reminders")
            .navigationBarItems(trailing: Button(action: {
                isAddReminderSheetPresented = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $isAddReminderSheetPresented) {
                AddReminderView(reminderStore: reminderStore)
            }
        }
    }
}

struct RemindersView_Preview: PreviewProvider {
    static var previews: some View {
        RemindersView()
    }
}



