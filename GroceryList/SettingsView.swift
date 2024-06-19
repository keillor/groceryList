//
//  SettingsView.swift
//  GroceryList
//
//  Created by Keillor Jennings on 5/8/24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var manager : GroceryListManager
    @State var isAlertEraseAll : Bool = false
    @State private var isAlertRemoveCompleted : Bool = false
    var body: some View {
        NavigationView {
            Form {
                Section("Remove Tasks") {
                    //Remove completed Tasks button
                    Button(role: .destructive, action: {
                        isAlertRemoveCompleted = true
                    }) {
                        Label("Remove All Complete", systemImage: "checklist.checked").foregroundColor(.red)
                    }.alert(isPresented: $isAlertRemoveCompleted, content: {
                        Alert(title: Text("Would you like to delete all completed items?"), primaryButton: Alert.Button.cancel(), secondaryButton: Alert.Button.destructive(Text("Delete"), action: {
                            manager.RemoveAllCompleted()
                        }))
                    })
                    
                    //Erase All Tasks Button
                    Button(role: .destructive, action: {
                        isAlertEraseAll = true
                    }) {
                        Label("Erase All Tasks", systemImage: "eraser.line.dashed").foregroundColor(.red)
                    }.alert(isPresented: $isAlertEraseAll, content: {
                        Alert(title: Text("Delete All Confirmation"), primaryButton: Alert.Button.cancel(), secondaryButton: Alert.Button.destructive(Text("Delete"), action: {
                            manager.RemoveAllItems()
                            isAlertEraseAll = false
                            
                        }))
                    })
                }
            }.navigationTitle("Settings")
        }
    }
}
