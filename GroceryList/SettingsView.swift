//
//  SettingsView.swift
//  GroceryList
//
//  Created by Keillor Jennings on 5/8/24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var manager : GroceryListManager
    @State var isAlert : Bool = false
    var body: some View {
        NavigationView {
            Form {
                Section("Options") {
                    Toggle(isOn: $manager.onlyUncomplete) {
                        Text("Show only incomplete")
                    }
                    Button(role: .destructive, action: {
                        manager.myList.removeAll(where: {$0.completed == true})
                    }) {
                        Label("Remove All Complete", systemImage: "eraser.line.dashed").foregroundColor(.red)
                    }
                    Button(action: {
                        manager.selectedFilterCategory.removeAll()
                        manager.onlyUncomplete = false
                    }){
                        Label("Unselect All Filters", systemImage: "xmark.circle")
                    }
                }
                Section("Erase All") {
                    Button(role: .destructive, action: {
                        isAlert = true
                    }) {
                        Label("Erase All Tasks", systemImage: "eraser.line.dashed").foregroundColor(.red)
                    }.alert(isPresented: $isAlert, content: {
                        Alert(title: Text("Delete All Confirmation"), primaryButton: Alert.Button.cancel(), secondaryButton: Alert.Button.default(Text("Delete"), action: {
                            manager.myList.removeAll()
                            isAlert = false
                            manager.Save()
                        }))
                    })
                }
            }.navigationTitle("Settings")
        }
    }
}
