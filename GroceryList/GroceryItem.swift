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
    case Meats = "Meats"
    case Canned = "Canned Food"
    case Frozen = "Frozen"
    case Condiments = "Condiments"
    case Snacks = "Snacks"
    case Drinks = "Drinks"
    case Paper_Products
    case Household = "Household"
    case Personal_Items = "Personal Items"
    case Pets = "Pets"
    case Dairy = "Dairy"
    case Other = "Other"
    
    var emoji: (String) {
            switch self {
            case .Fruits:
                return ("🍎")
            case .Vegtables:
                return ("🥦")
            case .Meats:
                return ("🍣")
            case .Canned:
                return ("🥫")
            case .Frozen:
                return("🧊")
            case .Condiments:
                return("🌭")
            case .Snacks:
                return ("🍪")
            case .Drinks:
                return("🧃")
            case .Paper_Products:
                return("🧻")
            case .Household:
                return("🧼")
            case .Personal_Items:
                return("🪒")
            case .Pets:
                return("🐶")
            case .Dairy:
                return("🥛")
            case .Other:
                return("🪄")
            }
        }
    var bgcolor: (Color) {
        switch self {
        case .Fruits:
            return (.red)
        case .Vegtables:
            return (.orange)
        case .Meats:
            return (.yellow)
        case .Canned:
            return (.green)
        case .Frozen:
            return (.blue)
        case .Condiments:
            return (.indigo)
        case .Snacks:
            return (.purple)
        case .Drinks:
            return (.pink)
        case .Paper_Products:
            return (.brown)
        case .Household:
            return (.teal)
        case .Personal_Items:
            return (.mint)
        case .Pets:
            return (.brown)
        case .Dairy:
            return (.blue)
        case .Other:
            return (.gray)
        }
    }
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
class GroceryListManager: ObservableObject, Identifiable {
    @Published var myList : [singleGroceryItem] = []
    @Published var selectedFilterCategory : [groceryType] = []
    @Published var onlyUncomplete : Bool = false
    var fileurl: URL
    
    // Initializes the manager and also attempts to load persistent data
    init() {
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.fileurl = directory.appendingPathComponent("grocery").appendingPathExtension(".plist")
        Load()
    }
    
    init(id : UUID) {
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.fileurl = directory.appendingPathComponent(id.uuidString).appendingPathExtension(".plist")
        Load()
    }
    
    func Refresh() {
        let copy_list = self.myList
        self.myList = copy_list
    }
    
    func get()->[singleGroceryItem] {
        //apply filter if present
        var copy = myList
        if !selectedFilterCategory.isEmpty {
            copy = myList.filter {selectedFilterCategory.contains($0.grocery_type)}
        }
        if onlyUncomplete {
            copy = copy.filter {$0.completed == false}
        }
        
        return copy
    }
    
    // Adds an item into the grocery list. This also saves the list.
    func AddGroceryItem(_ newItem: singleGroceryItem) -> Void {
        myList.append(newItem)
        return
    }
    func RemoveGroceryAtIndex(_ index: Int) -> Void {
        myList.remove(at: index)
        return
    }
    func ReplaceGroceryAtIndex(_ index: Int, _ newItem: singleGroceryItem) {
        myList.replaceSubrange(index..<index+1, with: [newItem])
        return
    }
    
    func SortGroceryByEnum(_ selectedGroceryEnum: groceryType) -> Array<singleGroceryItem> {
        let enumSearch = myList.filter {$0.grocery_type == selectedGroceryEnum}
        return enumSearch
    }
    
    func FindByUUID(_ id: UUID)-> singleGroceryItem? {
        if let index = myList.firstIndex(where: {$0.id == id}) {
            return myList[index]
        }
        return nil
    }
    
    func ReplaceByUUID(_ id: UUID, _ item: singleGroceryItem) {
        if let index = myList.firstIndex(where: {$0.id == id}) {
            myList[index] = item
        }
        return
        
    }
    
    func RemoveAllCompleted() {
        myList.removeAll(where: {$0.completed == true})
        return
    }
    
    func RemoveAllFilters() {
        selectedFilterCategory.removeAll()
        onlyUncomplete = false
        return
    }
    
    func RemoveByCategory(category: groceryType) {
        myList.removeAll(where: {
            $0.grocery_type == category
        })
    }
    
    func isTripCompleted() -> Bool {
        if myList.isEmpty {
            return false
        }
        if myList.contains(where: {
            $0.completed == false
        }) {
            return false
        }
        return true
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
    
    func itemCountsByCategories()-> [groceryType: Int] {
        // returns a dictionary, with the keys being the groceryType enum
        // and the values is an integer of how many uncompleted items are in that category
        var itemCountsByCategory: [groceryType: Int] = [:]
        for type in groceryType.allCases {
            let count = myList.filter {$0.grocery_type == type && $0.completed == false}.count
            itemCountsByCategory[type] = count
        }
        return itemCountsByCategory
    }
    
    func sampleData() {
        self.myList.removeAll()
        self.AddGroceryItem(singleGroceryItem(title: "Food", description: "", quantity: 1, completed: false, grocery_type: groceryType.Canned))
        self.AddGroceryItem(singleGroceryItem(title: "Food", description: "", quantity: 1, completed: false, grocery_type: groceryType.Condiments))
        self.AddGroceryItem(singleGroceryItem(title: "Food", description: "", quantity: 1, completed: false, grocery_type: groceryType.Dairy))
        self.AddGroceryItem(singleGroceryItem(title: "Food", description: "", quantity: 1, completed: false, grocery_type: groceryType.Drinks))
        self.AddGroceryItem(singleGroceryItem(title: "Food", description: "", quantity: 1, completed: false, grocery_type: groceryType.Frozen))
        self.AddGroceryItem(singleGroceryItem(title: "Food", description: "", quantity: 1, completed: false, grocery_type: groceryType.Fruits))
        self.AddGroceryItem(singleGroceryItem(title: "Food", description: "", quantity: 1, completed: false, grocery_type: groceryType.Household))
        self.AddGroceryItem(singleGroceryItem(title: "Food", description: "", quantity: 1, completed: false, grocery_type: groceryType.Meats))
        self.AddGroceryItem(singleGroceryItem(title: "Food", description: "", quantity: 1, completed: false, grocery_type: groceryType.Other))
        self.AddGroceryItem(singleGroceryItem(title: "Food", description: "", quantity: 1, completed: false, grocery_type: groceryType.Paper_Products))
        self.AddGroceryItem(singleGroceryItem(title: "Food", description: "", quantity: 1, completed: false, grocery_type: groceryType.Personal_Items))
        self.AddGroceryItem(singleGroceryItem(title: "Food", description: "", quantity: 1, completed: false, grocery_type: groceryType.Pets))
        self.AddGroceryItem(singleGroceryItem(title: "Food", description: "", quantity: 1, completed: false, grocery_type: groceryType.Snacks))
        self.AddGroceryItem(singleGroceryItem(title: "Food", description: "", quantity: 1, completed: false, grocery_type: groceryType.Vegtables))
        self.Save()
    }
}

//#Preview {
//    GroceryItem()
//}
