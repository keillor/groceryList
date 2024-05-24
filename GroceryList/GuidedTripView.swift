//
//  GuidedTripView.swift
//  GroceryList
//
//  Created by Keillor Jennings on 5/7/24.
//

import SwiftUI
import ConfettiSwiftUI

struct GuidedTripView: View {
    @EnvironmentObject var manager : GroceryListManager
    @State var confet : Int = 0
    @State private var isConfettiSheetShowing = false
    var body: some View {
        NavigationView {
            List {
                ForEach(manager.itemCountsByCategories().filter {$0.value > 0}.sorted { $0.key.rawValue < $1.key.rawValue}, id: \.key) { (type, count) in
                    HStack {
                        ItemCountGenerator(count: count, type: type)
                        Text(type.rawValue)
                        Spacer()
                        NavigationLink(destination: FilteredListGenerator(type: type)){}.buttonStyle(.borderless).frame(width: 0, height: 0).opacity(0)
                        EmojiView(groceryEnum: type)
                    }
                }
                
            }.overlay(content: {
                if manager.isTripCompleted() {
                    Text("Yay! Trip Completed!").confettiCannon(counter: $confet).onAppear(perform: {
                        confet += 1
                    })
                }
            }).navigationTitle("Guided Trip Mode")
        }.sheet(isPresented: $isConfettiSheetShowing, content: {
            Text("Yay! Trip Complete!").confettiCannon(counter: $confet).onAppear(perform: {
                confet += 1
            })
        })
    }
}
