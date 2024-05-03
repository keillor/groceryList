//
//  EmojiView.swift
//  GroceryList
//
//  Created by Keillor Jennings on 5/1/24.
//

import SwiftUI


struct EmojiView: View {
    var groceryEnum : groceryType
    var body: some View {
        RoundedRectangle(cornerRadius: 15.0).fill(groceryEnum.bgcolor).frame(width: 40, height: 40).overlay() {Text(groceryEnum.emoji).font(.title).shadow(color: .black, radius: 10)}
        //Text(groceryEnum.emoji)
    }
}

//#Preview {
//    EmojiView(groceryEnum: groceryType.Other)
//}
