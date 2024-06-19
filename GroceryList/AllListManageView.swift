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
    @State var isShowingEditListTitleSheet : Bool = false
    @State var newListTitle : String = ""
    @State var editListUUID : UUID = UUID()
    var body: some View {
        VStack {
            Button(action: {
                isShowingNewListSheet.toggle()
            }) {
                Text("Push to add new list")
            }.sheet(isPresented: $isShowingNewListSheet, content: {
                VStack {
                    Text("Create a New List").underline().font(.largeTitle)
                                             .bold()
                                             .foregroundStyle(
                                                LinearGradient(
                                                    colors: [.red, .blue, .green, .yellow],
                                                    startPoint: .leading,
                                                    endPoint: .trailing))
                                             .padding()
                    TextField("New List Title", text: $newListTitle, prompt: Text("New List Title")).padding().clipShape(Capsule()).overlay(Capsule().stroke(lineWidth: 3).foregroundStyle(.blue)).padding().onSubmit {
                        if(newListTitle == "") {
                            return
                        }
                        multiManager.createNewList(name: newListTitle) // _ = multiManager.createNewList ##ignores the return value
                        isShowingNewListSheet.toggle()
                        newListTitle = ""
                    }
                    Button(action: {
                        if(newListTitle == "") {
                            return
                        }
                        multiManager.createNewList(name: newListTitle) // _ = multiManager.createNewList ##ignores the return value
                        isShowingNewListSheet.toggle()
                        newListTitle = ""
                    }) {
                        Text("Save New List").bold()
                    }.frame(maxWidth: .infinity).font(.title3).foregroundStyle(.white).padding().background(.blue).clipShape(Capsule()).overlay(Capsule().stroke(lineWidth: 3).foregroundStyle(.blue)).padding()
                }
                
            }).sheet(isPresented: $isShowingEditListTitleSheet, content: {
                VStack {
                    Text("Update List Name").underline().font(.largeTitle)
                                             .bold()
                                             .foregroundStyle(.blue)
                                             .padding()
                    TextField("Renamed List Title", text: $newListTitle, prompt: Text("Renamed List Title")).padding().clipShape(Capsule()).overlay(Capsule().stroke(lineWidth: 3).foregroundStyle(.blue)).padding().onSubmit {
                        multiManager.RenameList(key: editListUUID, newTitle: newListTitle)
                    }
                    Button(action: {
                        multiManager.RenameList(key: editListUUID, newTitle: newListTitle)
                        isShowingEditListTitleSheet = false
                    }) {
                        Text("Update Name")
                    }.frame(maxWidth: .infinity).font(.title3).foregroundStyle(.white).padding().background(.blue).clipShape(Capsule()).overlay(Capsule().stroke(lineWidth: 3).foregroundStyle(.blue)).padding()
                }
                
            })
            
            Button(action: {
                multiManager.RemoveAll()
            }) {
                Text("Remove All")
            }
            
            List {
                ForEach(multiManager.allLists.elements, id: \.key) { element in
                    NavigationLink {
                        ContentView().environmentObject(GroceryListManager(id: element.key, title: element.value))
                    } label: {
                        Text("\(element.value)")
                    }.swipeActions(content: {
                        Button(role: .destructive, action: {
                            withAnimation {
                                multiManager.DeleteList(element.key)
                            }
                            
                        }) {
                            Image(systemName: "trash")
                        }
                        Button(action: {
                            self.editListUUID = element.key
                            self.newListTitle = element.value
                            self.isShowingEditListTitleSheet = true
                        }) {
                            Image(systemName: "pencil")
                        }.tint(.yellow)

                    })

                }.onDelete(perform: { indexSet in
                    multiManager.DeleteList(indexSet)
                })

            }
            
            
        }
        
        
    }
}
