//
//  GroceryViews.swift
//  GroceryList
//
//  Created by Erik Nguyen on 3/29/24.
//

import SwiftUI


struct GroceryListView: View {
    @EnvironmentObject var manager: GroceryListManager
    @State private var isShowingFilter = false
    @State private var isShowingNewItem = false
    
    var body: some View {
        NavigationView {
            VStack{
                Text("Grocery List")
                Spacer()
                Button(action: {
                    isShowingFilter.toggle()
                }) {
                    Label("Filter", systemImage: "line.3.horizontal.decrease.circle").sheet(isPresented: $isShowingFilter
                    ) {
                        FilterView()
                    }
                }
                if(!manager.selectedFilterCategory.isEmpty || manager.onlyUncomplete) {
                    Button(action: {
                        manager.selectedFilterCategory.removeAll()
                        manager.onlyUncomplete = false
                    }) {
                        Label("Filters active! Tap to clear", systemImage: "xmark.circle")
                    }.foregroundColor(.red).buttonStyle(.plain)
                }

                ListGenerator()
                
                // Test button that just adds milk
                Button(action: {
                    isShowingNewItem.toggle()

                }) {
                    Label("Add New Item", systemImage: "plus.circle")
                }.sheet(isPresented: $isShowingNewItem) {
                    AddGroceryForm()
                }
                Button(action: {
                    manager.AddGroceryItem(singleGroceryItem(title: "Apple", description: "Fresh and juicy", quantity: 3, completed: false, grocery_type: .Fruits, price: 2))
                    manager.AddGroceryItem(singleGroceryItem(title: "Broccoli", description: "Green and nutritious", quantity: 1, completed: false, grocery_type: .Vegtables, price: 1.5))
                    manager.AddGroceryItem(singleGroceryItem(title: "Chicken Breast", description: "Lean protein", quantity: 2, completed: false, grocery_type: .Meats, price: 5))
                    manager.AddGroceryItem(singleGroceryItem(title: "Canned Soup", description: "Quick meal option", quantity: 4, completed: false, grocery_type: .Canned, price: 3))
                    manager.AddGroceryItem(singleGroceryItem(title: "Frozen Pizza", description: "Convenient dinner", quantity: 1, completed: false, grocery_type: .Frozen, price: 8))
                    manager.AddGroceryItem(singleGroceryItem(title: "Ketchup", description: "Essential condiment", quantity: 1, completed: false, grocery_type: .Condiments, price: 2.5))
                    manager.AddGroceryItem(singleGroceryItem(title: "Chips", description: "Crunchy snacks", quantity: 2, completed: false, grocery_type: .Snacks, price: 4))
                    manager.AddGroceryItem(singleGroceryItem(title: "Orange Juice", description: "Freshly squeezed", quantity: 1, completed: false, grocery_type: .Drinks, price: 3))
                    manager.AddGroceryItem(singleGroceryItem(title: "Toilet Paper", description: "Soft and absorbent", quantity: 1, completed: false, grocery_type: .Paper_Products, price: 6))
                    manager.AddGroceryItem(singleGroceryItem(title: "Laundry Detergent", description: "Cleans clothes effectively", quantity: 1, completed: false, grocery_type: .Household, price: 7))
                    manager.AddGroceryItem(singleGroceryItem(title: "Shampoo", description: "For clean and healthy hair", quantity: 1, completed: false, grocery_type: .Personal_Items, price: 4))
                    manager.AddGroceryItem(singleGroceryItem(title: "Dog Food", description: "Nutritious meal for your pet", quantity: 1, completed: false, grocery_type: .Pets, price: 9))
                    manager.AddGroceryItem(singleGroceryItem(title: "Batteries", description: "Power for your devices", quantity: 4, completed: false, grocery_type: .Other, price: 10))

                }) {
                    Label("Add Test Items", systemImage: "paperplane.circle")
                }

            }
        }
    }
}


struct AddGroceryForm: View {
    @EnvironmentObject var manager: GroceryListManager
    
    @State var title_form: String = ""
    @State var description_form: String = ""
    
    @State var quantity_form: String = "1"
    @State var quantity: Float = 1
    
    @State var grocery_type: groceryType = .Other
    
    @State var price_form: String = ""
    @State var price : Float?
    
    var body: some View {
        NavigationView {
                // Form Fields
            Form {
                Section() {
                    HStack {
                        Text("Item:").bold()
                        TextField("Item",text: $title_form)
                    }
                    HStack {
                        Text("Description:").bold()
                        TextField("Description", text: $description_form)
                    }
                    HStack {
                        Text("Quantity: \(quantity.formatted(.number.precision(.fractionLength(0))))")
                        Stepper(value: $quantity, in: 1...100, step: 1) {
                            //
                        }
                    }
                    HStack {
                        Text("Price").bold()
                        TextField("PRICE", text: $price_form).keyboardType(.decimalPad)
                            .onChange(of: price_form) {
                                field in
                                if let value = Float(field) {
                                    price = value
                                }
                            }
                    }
                    Picker("Grocery Type", selection: $grocery_type) {
                        ForEach(groceryType.allCases, id: \.self) {
                            option in
                            Text(option.rawValue).tag(option)
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    
                }
                /*Section {
                    Text("Quantity")
                    TextField("QUANTITY", text: $quantity_form).keyboardType(.decimalPad)
                        .onChange(of: quantity_form) {
                            field in
                            if let value = Float(field) {
                                quantity = value
                            }
                        }
                }*/
                // Add item button
                Button(action: {
                    let item = singleGroceryItem(title: title_form, description: description_form, quantity: quantity, completed: false, grocery_type: grocery_type, price: price)
                    manager.AddGroceryItem(item)
                    manager.Save()
                    
                    // Resets form inputs to defaults
                    title_form = ""
                    description_form = ""
                    quantity_form = "1"
                    quantity = 1
                    grocery_type = .Other
                    price_form = ""
                    price = nil
                }) {
                    Text("Add Item to List")
                }
            }.navigationTitle("Item Edit")
        }
    }
}

