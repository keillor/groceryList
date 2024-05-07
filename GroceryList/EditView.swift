//
//  EditView.swift
//  GroceryList
//
//  Created by Erik Nguyen on 5/3/24.
//

import SwiftUI

struct EditView: View {
    @EnvironmentObject var manager : GroceryListManager
    var uuid : UUID
    
    @State var title_form: String = ""
    @State var description_form: String = ""
    @State var is_complete: Bool = false
    
    @State var quantity_form: String = "1"
    @State var quantity: Float = 1
    
    @State var grocery_type: groceryType = .Other
    
    @State var price_form: String = ""
    @State var price : Float?
    
    init(uuid: UUID) {
        self.uuid = uuid
    }
    
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
                    let item = singleGroceryItem(title: title_form, description: description_form, quantity: quantity, completed: self.is_complete, grocery_type: grocery_type, price: price)
                    manager.ReplaceByUUID(self.uuid, item)
                    manager.Save()
                }) {
                    Text("Confirm Changes")
                }
            }.navigationTitle("Item Edit")
        }.onAppear {
            
            if let grocery_item = manager.FindByUUID(self.uuid) {
                title_form = grocery_item.title
                description_form = grocery_item.description

                quantity_form = String(grocery_item.quantity)
                quantity = grocery_item.quantity

                grocery_type = grocery_item.grocery_type

                if let priceValue = grocery_item.price {
                    price_form = String(priceValue)
                    price = priceValue
                }
                
                is_complete = grocery_item.completed
            }
            
        }
    }
}
