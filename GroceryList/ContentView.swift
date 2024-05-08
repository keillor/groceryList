//
//  ContentView.swift
//  GroceryList
//
//  Created by Keillor Jennings on 3/11/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isSplashFinished = false
    @StateObject var manager = GroceryListManager()
    
    var body: some View {
        
        ZStack {
            
            if isSplashFinished {
                
                
                TabView {
                    GroceryListView().tabItem {
                        Image(systemName: "globe")
                        Text("Grocery List")
                    }
                    
                    GuidedTripView().tabItem {
                        Image(systemName: "cart")
                        Text("Store Mode")
                    }
                    
                    AddGroceryForm().tabItem {
                        Image(systemName: "plus")
                        Text("Add Item")
                    }
                    SettingsView().tabItem {
                        Image(systemName: "gear")
                        Text("Options")
                    }
                }
                .environmentObject(manager)
                .transition(.scale)
                
            } else {
                SplashView(isActive: isSplashFinished)
            }
        }
        .onAppear {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isSplashFinished = true
                }
            }
        }
        
    }
}

//#Preview {
    //ContentView()
//}
