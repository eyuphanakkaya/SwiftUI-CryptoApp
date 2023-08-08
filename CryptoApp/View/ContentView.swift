//
//  ContentView.swift
//  CryptoApp
//
//  Created by Eyüphan Akkaya on 7.08.2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = CryptoViewModel()
    var body: some View {
        ZStack {
            TabView {
                HomePage(viewModel: viewModel)
                    .tabItem {
                        Image(systemName: "homekit")
                    }
                MarketPage(viewModel: viewModel)
                    .tabItem {
                       Image(systemName: "basket")
                    }
                ProfilePage()
                    .tabItem {
                        Image(systemName: "person")
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
