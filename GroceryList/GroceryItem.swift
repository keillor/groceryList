//
//  SwiftUIView.swift
//  GroceryList
//
//  Created by Keillor Jennings on 3/11/24.
//

import SwiftUI

struct GroceryItem: View {
    var body: some View {
        Text("Hello, World!")
    }
}

enum groceryType: String{
    case Fruits  = "Fruits"
    case Vegtables = "Vegtables"
    case Meats = "Means"
    case Canned = "Canned Food"
    case Frozen = "Frozen"
    case Condiments = "Condiments"
    case Snacks = "Snacks"
    case Drinks = "Drinks"
    case Paper_Products
    case Household = "Household"
    case Personal_Items = "Personal Items"
    case Pets = "Pets"
    case Other = "Other"
}

class singleGroceryItem {
    var title : String
    var description : String
    var quantity : Float
    var completed : Bool
    var grocery_type : groceryType
    var price : Float?
    
    init(title: String, description: String, quantity: Float, completed: Bool, grocery_type: groceryType) {
        self.title = title
        self.description = description
        self.quantity = quantity
        self.completed = completed
        self.grocery_type = grocery_type
    }
    init() {
        self.title = ""
        self.description = ""
        self.quantity = 0.0
        self.completed = false
        self.grocery_type = groceryType.Other
    }
}

class GroceryListManager {
    var myList : Array<singleGroceryItem> = []
    
    func AddGroceryItem(_ newItem: singleGroceryItem) -> Void {
        myList.append(newItem)
        return
    }
    func RemoveGroceryAtIndex(_ index: Int) -> Void {
        myList.remove(at: index)
        return
    }
    func SortGroceryByEnum(_ selectedGroceryEnum: groceryType) {
        let enumSearch = myList.filter {$0.grocery_type == selectedGroceryEnum}
    }
}

#Preview {
    GroceryItem()
}
