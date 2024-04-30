//
//  modifiers.swift
//  GroceryList
//
//  Created by Keillor Jennings on 4/26/24.
//

import SwiftUI

struct modifiers: ViewModifier {
    func body(content: Content) -> some View {
        content.padding(5).clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/).overlay(Circle().stroke(lineWidth:5).foregroundColor(.clear))
    }
}
