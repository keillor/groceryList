//
//  AllListManageView.swift
//  GroceryList
//
//  Created by Keillor Jennings on 5/29/24.
//

import SwiftUI

struct AllListManageView: View {
    @EnvironmentObject var multiManager : MultiListManager
    @State var isShowingNewListSheet : Bool = false
    @State var newListTitle : String = ""
    var body: some View {
        VStack {
            Button(action: {
                isShowingNewListSheet.toggle()
            }) {
                Text("Push to add new list")
            }.sheet(isPresented: $isShowingNewListSheet, content: {
                TextField("New List Title", text: $newListTitle, prompt: Text("New List Title")).padding().clipShape(Capsule()).overlay(Capsule().stroke(lineWidth: 3).foregroundStyle(.blue)).padding()
                Button(action: {
                    if(newListTitle == "") {
                        
                    } else {
                        _ = multiManager.createNewList(name: newListTitle) // _ = multiManager.createNewList ##ignores the return value
                        isShowingNewListSheet.toggle()
                        newListTitle = ""
                        print(multiManager.allLists)
                    }
                    
                    
                }) {
                    Text("Save New List")
                }.buttonStyle(.borderedProminent)
            })
            
            Button(action: {
                multiManager.allLists.removeAll()
                multiManager.save()
            }) {
                Text("Remove All")
            }
            
            List {
                ForEach(multiManager.allLists.elements, id: \.key) { element in
                    NavigationLink {
                        ContentView().environmentObject(GroceryListManager(id: element.key))
                    } label: {
                        Text("\(element.value)")
                    }.swipeActions(content: {
                        Button(role: .destructive) {
                            //TODO
                        } label: {
                            //TODO
                        }

                    })

                }.onDelete(perform: { indexSet in
                    
                    //TODO
                    //make this a function inside of multiManager
                    multiManager.DeleteList(indexSet)
                })

            }
            
            
        }
        
        
    }
}
