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
        NavigationView {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Grocery List")
                Spacer()
                
                // Portion of the View that contains the list
                ForEach(manager.myList) {
                    item in HStack {
                        Image(systemName: item.completed ? "checkmark.square" : "square")
                        VStack {
                            Text("\(item.title)  |  \(item.description)")
                            Text("\(Int(item.quantity)) items")
                        }
                        Image(systemName: "ellipsis")
                    }
                }
                Spacer()
                
                // Test button that just adds milk
                Button(action: {
                    let item = singleGroceryItem(title: "Milk", description: "2% fat", quantity: 2, completed: false, grocery_type: .Drinks)
                    manager.AddGroceryItem(item)
                }) {
                    Text("Add Test Item to List")
                }
            }
            .padding()
        }
    }
}

//#Preview {
//    ContentView()
//}
