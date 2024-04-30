//
//  GroceryViews.swift
//  GroceryList
//
//  Created by Erik Nguyen on 3/29/24.
//

import SwiftUI


struct GroceryListView: View {
    @EnvironmentObject var manager: GroceryListManager
    @State private var isShowingSheet = true
    
    var body: some View {
        NavigationView {
            VStack{
                Text("Grocery List")
                Spacer()
                Button(action: {
                    isShowingSheet.toggle()
                }) {
                    Text("Filter").sheet(isPresented: $isShowingSheet
                    ) {
                 VStack {
                     Text("Filters")
                         .font(.title)
                         .padding(50)
                     ScrollView (.horizontal,showsIndicators: false){
                         HStack{
                                 ForEach(groceryType.allCases, id: \.rawValue) { item in
                                     Button(action: {
                                         if manager.selectedFilterCategory.contains(item) {
                                             if let number = manager.selectedFilterCategory.firstIndex(of: item) {
                                                 manager.selectedFilterCategory.remove(at: number)
                                             }
                                         } else {
                                             manager.selectedFilterCategory.append(item)
                                         }
                                     }) {
                                         Text(item.rawValue).padding(5).background(manager.selectedFilterCategory.contains(item) ? .blue : .clear)
                                     }.clipShape(Capsule()).foregroundColor(manager.selectedFilterCategory.contains(item) ? .white : .gray).overlay(Capsule().stroke(lineWidth: 1).foregroundColor(manager.selectedFilterCategory.contains(item) ? .blue : .gray))
                                 }
                         }
                     }
                     Toggle(isOn: $manager.onlyUncomplete) {
                         Text("Show only completed")
                     }
                     Button(action: {
                         manager.myList.removeAll(where: {$0.completed == true})
                     }, label: {
                         Text("Remove All Completed")
                     }).buttonStyle(.borderedProminent)
                     
                     
                     
                     
                     Button(action: { 
                         manager.selectedFilterCategory.removeAll()
                         manager.onlyUncomplete = false
                     }){
                         HStack {
                             Text("Clear All")
                             Image(systemName: "xmark.circle")
                         }
                     }.buttonStyle(.plain).foregroundColor(.red)
                 }
             }
                }
                if(!manager.selectedFilterCategory.isEmpty) {
                    Button(action: {
                        manager.selectedFilterCategory.removeAll()
                    }) {
                        Text("Filters active! Click to clear")
                    }
                }

                List {

                    // Portion of the View that contains the list
                    ForEach(manager.get()) {
                        item in HStack {
                            Button(action:{
                                item.completed = !item.completed
                                manager.Refresh()
                            }) {
                                Image(systemName: item.completed ? "checkmark.square" : "square")
                            }
                            VStack {
                                Text("\(item.title)  |  \(item.description)")
                                Text("\(Int(item.quantity)) items")
                            }
                            Image(systemName: "ellipsis")
                        }
                    } .onDelete(perform: { offset in
                        manager.myList.remove(atOffsets: offset)
                        manager.Save()
                    })
                    .onMove(perform: { indices, newOffset in
                        manager.myList.move(fromOffsets: indices, toOffset: newOffset)
                        manager.Save()
                    })
                }
                
                // Test button that just adds milk
                Button(action: {
                    let item = singleGroceryItem(title: "Milk", description: "2% fat", quantity: 2, completed: false, grocery_type: .Drinks)
                    manager.AddGroceryItem(item)
                }) {
                    Text("Add Test Item")
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
            VStack {
                // Form Fields
                Text("Grocery Title")
                TextField("TITLE", text: $title_form).padding()
                Text("Description")
                TextField("DESCRIPTION", text: $description_form).padding()
                HStack {
                    VStack {
                        Text("Quantity")
                        TextField("QUANTITY", text: $quantity_form).keyboardType(.decimalPad)
                            .onChange(of: quantity_form) {
                                field in
                                if let value = Float(field) {
                                    quantity = value
                                }
                            }
                    }.padding()
                    VStack {
                        Text("Price")
                        TextField("PRICE", text: $price_form).keyboardType(.decimalPad)
                            .onChange(of: price_form) {
                                field in
                                if let value = Float(field) {
                                    price = value
                                }
                            }
                    }.padding()
                }
                
                // Picker for grocery type
                Picker("Grocery Type", selection: $grocery_type) {
                    ForEach(groceryType.allCases, id: \.self) {
                        option in
                        Text(option.rawValue).tag(option)
                    }
                    .pickerStyle(MenuPickerStyle())
                }.padding()
                
                // Add item button
                Button(action: {
                    let item = singleGroceryItem(title: title_form, description: description_form, quantity: quantity, completed: false, grocery_type: grocery_type, price: price)
                    manager.AddGroceryItem(item)
                    
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
                }.padding()
            }
        }
    }
}

