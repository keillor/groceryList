//
//  ListGenerator.swift
//  GroceryList
//
//  Created by Keillor Jennings on 5/7/24.
//

import SwiftUI

struct ListGenerator: View {
    @EnvironmentObject var manager : GroceryListManager
    @State private var rotationAngle: Double = 0
    var body: some View {
        List {
            ForEach($manager.myList, id: \.id) {
                item in HStack {
                    SingleItemGeneratorView(item: item)
                    /*
                    Button(action:{
                        item.completed.toggle()
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0.5)) {
                            manager.Refresh()
                            rotationAngle += 360
                        }
                        
                        manager.Save()
                    }) {
                        Image(systemName: item.completed ? "checkmark.circle.fill" : "circle").imageScale(.large).foregroundColor(item.grocery_type.bgcolor).scaleEffect(item.completed ? 1.2 : 1.0)
                            .animation(.snappy, value: item.completed).rotationEffect(
                                .degrees(item.completed ? rotationAngle : 0)
                            )
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
                    EmojiView(groceryEnum: item.grocery_type)*/
                }
            } .onDelete(perform: { offset in
                manager.myList.remove(atOffsets: offset)
                manager.Save()
            })
            .onMove(perform: { indices, newOffset in
                manager.myList.move(fromOffsets: indices, toOffset: newOffset)
                manager.Save()
            })
        }.transition(.slide)
    }
}
