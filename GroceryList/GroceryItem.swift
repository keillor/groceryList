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

/// Enum that contains the categories of grocery items
enum groceryType: String, CaseIterable {
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

/// Grocery Item Class that encapsulates the various properties of grocery items
class singleGroceryItem: ObservableObject, Identifiable {
    @Published var title : String
    @Published var description : String
    @Published var quantity : Float
    @Published var completed : Bool
    var grocery_type : groceryType
    var price : Float?
    
    init(title: String, description: String, quantity: Float, completed: Bool, grocery_type: groceryType, price: Float? = nil) {
        self.title = title
        self.description = description
        self.quantity = quantity
        self.completed = completed
        self.grocery_type = grocery_type
        self.price = price
    }
    init() {
        self.title = ""
        self.description = ""
        self.quantity = 0.0
        self.completed = false
        self.grocery_type = groceryType.Other
    }
}

/// Grocery List Manager Class contains a list of individual grocery items and provides adding, removal, sorting, and reading operations.
class GroceryListManager: ObservableObject {
    @Published var myList : Array<singleGroceryItem> = []
    
    func AddGroceryItem(_ newItem: singleGroceryItem) -> Void {
        myList.append(newItem)
        return
    }
    func RemoveGroceryAtIndex(_ index: Int) -> Void {
        myList.remove(at: index)
        return
    }
    func SortGroceryByEnum(_ selectedGroceryEnum: groceryType) -> Array<singleGroceryItem> {
        let enumSearch = myList.filter {$0.grocery_type == selectedGroceryEnum}
        return enumSearch
    }
}

//#Preview {
//    GroceryItem()
//}
