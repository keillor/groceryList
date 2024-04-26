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
enum groceryType: String, CaseIterable, Codable {
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
class singleGroceryItem: ObservableObject, Identifiable, Codable {
    var title : String
    var description : String
    var quantity : Float
    var completed : Bool
    var grocery_type : groceryType
    var price : Float?
    var id : UUID
    
    init(title: String, description: String, quantity: Float, completed: Bool, grocery_type: groceryType, price: Float? = nil) {
        self.title = title
        self.description = description
        self.quantity = quantity
        self.completed = completed
        self.grocery_type = grocery_type
        self.price = price
        self.id = UUID()
    }
    init() {
        self.title = ""
        self.description = ""
        self.quantity = 0.0
        self.completed = false
        self.grocery_type = groceryType.Other
        self.id = UUID()
    }
}

/// Grocery List Manager Class contains a list of individual grocery items and provides adding, removal, sorting, and reading operations.
class GroceryListManager: ObservableObject {
    @Published var myList : [singleGroceryItem] = []
    @Published var selectedFilterCategory : [groceryType] = []
    var fileurl: URL
    
    // Initializes the manager and also attempts to load persistent data
    init() {
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.fileurl = directory.appendingPathComponent("grocery").appendingPathExtension(".plist")
        Load()
    }
    
    func get()->[singleGroceryItem] {
        //apply filter if present
        if !selectedFilterCategory.isEmpty {
            return myList.filter {selectedFilterCategory.contains($0.grocery_type)}
        }
        
        return myList;
    }
    
    // Adds an item into the grocery list. This also saves the list.
    func AddGroceryItem(_ newItem: singleGroceryItem) -> Void {
        myList.append(newItem)
        Save()
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
    
    // Saves the grocery list data into an external file
    func Save() {
        let propertyListEncoder = PropertyListEncoder()
        if let encodedData = try? propertyListEncoder.encode(myList) {
            try? encodedData.write(to: self.fileurl, options: .noFileProtection)
        }
    }
    
    // Loads the grocery list data from an external file
    func Load() {
        let propertyListDecoder = PropertyListDecoder()
        if let fetchedData = try? Data(contentsOf: self.fileurl),
           let decodedData = try? propertyListDecoder.decode([singleGroceryItem].self, from: fetchedData) {
            self.myList = decodedData
        }
    }
}

//#Preview {
//    GroceryItem()
//}
