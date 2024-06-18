//
//  GroceryListApp.swift
//  GroceryList
//
//  Created by Keillor Jennings on 3/11/24.
//

import SwiftUI

@main
struct GroceryListApp: App {
    @StateObject var multiManager : MultiListManager = MultiListManager()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                AllListManageView().environmentObject(multiManager)
            }
        }
    }
}
