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
            }.navigationTitle("Add Item")
        }
    }
}

