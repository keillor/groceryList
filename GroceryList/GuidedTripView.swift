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
            if !manager.isTripCompleted() {
                List {
                    ForEach(manager.itemCountsByCategories().filter {$0.value > 0}.sorted { $0.key.rawValue < $1.key.rawValue}, id: \.key) { (type, count) in
                        HStack {
                            ItemCountGenerator(count: count, type: type)
                            Text(type.rawValue)
                            Spacer()
                            NavigationLink(destination: FilteredListGenerator(type: type)) {
                                
                            }.buttonStyle(.borderless).frame(width: 0, height: 0).opacity(0)
                            EmojiView(groceryEnum: type)
                        }
                        
                    }
                }.navigationTitle("Guided Trip Mode")
            } else if manager.isTripCompleted() {
                //add confetti!
                VStack {
                    Text("Yay!")
                }
            } else if manager.myList.isEmpty {
                VStack {
                    Text("Your list is empty!").font(.title2)
                    Text("🪷").font(.largeTitle)
                }
                
            }
        }
    }
}
