//
//  FilteredListGenerator.swift
//  GroceryList
//
//  Created by Keillor Jennings on 5/7/24.
//

import SwiftUI

struct FilteredListGenerator: View {
    @EnvironmentObject var manager : GroceryListManager
    let type : groceryType
    var body: some View {
        List {
            ForEach(Array(manager.myList.filter{ $0.grocery_type == type}.enumerated()), id: \.element.id ) {
                index, item in HStack {
                    Button(action:{
                        item.completed.toggle()
                        manager.Refresh()
                        manager.Save()
                    }) {
                        Image(systemName: item.completed ? "checkmark.circle.fill" : "circle").imageScale(.large).foregroundColor(.blue)
                    }.buttonStyle(.borderless)
                    //Text("\(Int(item.quantity)) x \(item.title)").font(.title2)
                    ItemCountGenerator(count: Int(item.quantity), type: item.grocery_type)
                    Text("\(item.title)").font(.title2)
                    Spacer()
                    
                    /*VStack {
                        Text("\(Int(item.quantity)) items")
                    }*/
                    NavigationLink(destination: EditView(uuid: item.id)) {
                        //Image(systemName: "pencil").imageScale(.large).foregroundColor(.blue)
                    }.buttonStyle(.borderless).frame(width: 0, height: 0).opacity(0)
                    EmojiView(groceryEnum: item.grocery_type)
                }
            } .onDelete(perform: { offset in
                manager.RemoveByOffset(offset)
            })
            .onMove(perform: { indices, newOffset in
                manager.myList.move(fromOffsets: indices, toOffset: newOffset)
                manager.Save()
            })
        }.navigationTitle("\(type.rawValue)")
    }
}
