//
//  FilterView.swift
//  GroceryList
//
//  Created by Keillor Jennings on 4/30/24.
//

import SwiftUI

struct FilterView: View {
    @EnvironmentObject var manager : GroceryListManager
    var body: some View {
        List {
            Section(header: Text("Sort by Category")) {
                ForEach(groceryType.allCases, id: \.rawValue) { item in
                    Button(action: {
                        if manager.selectedFilterCategory.contains(item) {
                            if let number = manager.selectedFilterCategory.firstIndex(of: item) {
                                manager.selectedFilterCategory.remove(at: number)
                                manager.Refresh()
                            }
                        } else {
                            manager.selectedFilterCategory.append(item)
                            manager.Refresh()
                        }
                    }) {
                        HStack {
                            if manager.selectedFilterCategory.contains(item) {
                                Image(systemName: "checkmark.circle.fill").imageScale(.large).foregroundColor(.green)
                            } else {
                                Image(systemName: "circle").imageScale(.large).foregroundColor(.green)
                            }
                            Text(item.rawValue).font(.title3)
                        }
                        
                    }.buttonStyle(.plain)
                }
                
                
            }
            
            /*ScrollView (.horizontal,showsIndicators: false){
                        ForEach(groceryType.allCases, id: \.rawValue) { item in
                            Button(action: {
                                if manager.selectedFilterCategory.contains(item) {
                                    if let number = manager.selectedFilterCategory.firstIndex(of: item) {
                                        manager.selectedFilterCategory.remove(at: number)
                                    }
                                } else {
                                    manager.selectedFilterCategory.append(item)
                                }
                            }) {
                                Text(item.rawValue).padding(5).background(manager.selectedFilterCategory.contains(item) ? .blue : .clear)
                            }.clipShape(Capsule()).foregroundColor(manager.selectedFilterCategory.contains(item) ? .white : .gray).overlay(Capsule().stroke(lineWidth: 1).foregroundColor(manager.selectedFilterCategory.contains(item) ? .blue : .gray))
                    }
                
                
            }*/
            Section(header: Text("Other Conditions")) {
                Button(action: {
                    manager.RemoveAllFilters()
                }) {
                    Label {
                        Text("Clear All Filters")
                    } icon: {
                        Image(systemName: "xmark.circle")
                    }

                }
                Toggle(isOn: $manager.onlyUncomplete) {
                    Text("Show only incomplete")
                }
                
            }
        }.navigationTitle("Filters & Options")
        
    }
}
