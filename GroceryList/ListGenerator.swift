//
//  ListGenerator.swift
//  GroceryList
//
//  Created by Keillor Jennings on 5/7/24.
//

import SwiftUI

struct ListGenerator: View {
    @EnvironmentObject var manager : GroceryListManager
    var body: some View {
        List {
            ForEach($manager.myList, id: \.id) {
                item in HStack {
                    SingleItemGeneratorView(item: item)
                }
            } .onDelete(perform: { offset in
                manager.RemoveByOffset(offset)
            })
            .onMove(perform: { indices, newOffset in
                manager.myList.move(fromOffsets: indices, toOffset: newOffset)
                manager.Save()
            })
        }.transition(.slide)
    }
}
