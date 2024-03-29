//
//  ContentView.swift
//  GroceryList
//
//  Created by Keillor Jennings on 3/11/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var manager = GroceryListManager()
    
    var body: some View {
        TabView {
            GroceryListView().tabItem {
                Image(systemName: "globe")
                Text("Grocery List")
            }
            AddGroceryForm().tabItem {
                Image(systemName: "plus")
                Text("Add Item")
            }
        }.environmentObject(manager)
    }
}

//#Preview {
//    ContentView()
//}
