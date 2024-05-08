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
                        .background(Color.black)
                    Image("GroceryListLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 900, height: 730)
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
