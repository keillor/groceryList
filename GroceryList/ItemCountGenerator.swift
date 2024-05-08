//
//  ItemCountGenerator.swift
//  GroceryList
//
//  Created by Keillor Jennings on 5/7/24.
//

import SwiftUI

struct ItemCountGenerator: View {
    let count : Int
    let type : groceryType
    var body: some View {
        RoundedRectangle(cornerRadius: 15.0).fill(type.bgcolor).frame(width: 40, height: 40).overlay() {
            Text(String(count)).foregroundStyle(.white).font(.title)
        }
    }
}
