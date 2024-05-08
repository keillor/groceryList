//
//  GuidedTripView.swift
//  GroceryList
//
//  Created by Keillor Jennings on 5/7/24.
//

import SwiftUI

struct GuidedTripView: View {
    @EnvironmentObject var manager : GroceryListManager
    var body: some View {
        NavigationView {
            if !manager.myList.isEmpty {
                List {
                    ForEach(manager.itemCountsByCategories().filter {$0.value > 0}, id: \.key) { (type, count) in
                        HStack {
                            ItemCountGenerator(count: count, type: type)
                            Text(type.rawValue)
                            Spacer()
                            NavigationLink(destination: FilteredListGenerator(type: type)) {
                                
                            }.buttonStyle(.borderless).frame(width: 0, height: 0).opacity(0)
                            EmojiView(groceryEnum: type)
                        }
                        
                    }
                }
            } else {
                Text("Yay! Your list is empty!")
            }
        }
    }
}
