//
//  SplashView.swift
//  GroceryList
//
//  Created by Daniel Hernandez on 5/8/24.
//

import SwiftUI

struct SplashView: View {
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack {
            if self.isActive {
                ContentView() } else {
                    Rectangle()
                        .background(Color.white)
                    Image("GroceryListLogo")
                        .frame(width: 500, height: 500)
                }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation { self.isActive = true
                }
            }
        }
    }
}

//#Preview {
    //SplashView()
//}
