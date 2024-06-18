//
//  ContentView.swift
//  GroceryList
//
//  Created by Keillor Jennings on 3/11/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var multiManager : MultiListManager
    @EnvironmentObject var manager : GroceryListManager
    
    var body: some View {
        TabView {
            GroceryListView().tabItem {
                Image(systemName: "globe")
                Text("Grocery List")
            }
            
            GuidedTripView().tabItem {
                Image(systemName: "cart")
                Text("Store Mode")
            }
            
            AddGroceryForm().tabItem {
                Image(systemName: "plus")
                Text("Add Item")
            }
            SettingsView().tabItem {
                Image(systemName: "gear")
                Text("Options")
            }
        }
    }
}

//#Preview {
    //ContentView()
//}
