//
//  MarketPage.swift
//  CryptoApp
//
//  Created by Eyüphan Akkaya on 8.08.2023.
//

import SwiftUI
import Charts

struct MarketPage: View {
    @State var coinList = [CoinModel]()
    @State var search = ""
    @State var selectedItem = true
    @ObservedObject var viewModel: CryptoViewModel
    
    var body: some View {
        NavigationStack {
            VStack{
                ScrollView {
                    HStack {

                            Button {
                                withAnimation {
                                    selectedItem = true
                                }
                              
                                print("Hepsi")
                            } label: {
                               
                                Text("All")
                                    .foregroundColor(.black)
                            }
                            .frame(width: 80)
                            .border(.gray)
                            .background(selectedItem ? Color.gray : Color.clear)
                            .cornerRadius(15)
                            .padding(.leading,10)
                            
                        
                            Button {
                                withAnimation {
                                    selectedItem = false
                                }
                                print("Favoriler")
                            } label: {
                                Text("Favorites")
                                    .foregroundColor(.black)
                            }
                            .frame(width: 100)
                            .background(selectedItem ? Color.clear : Color.gray )
                            .border(.gray)
                            .cornerRadius(15)
                            .padding(.leading,10)
                    }
                    
                }
                ScrollView{
                    ForEach(coinList) { list in
                        HomePageDesign(coin: list)
                    }
                }
                .frame(width: 200)
            }
        }.onAppear{
            viewModel.fetchCoinList { result in
                self.coinList.append(contentsOf: result)
            }
        }
        .searchable(text: $search)

    }

}

struct MarketPage_Previews: PreviewProvider {
    static var previews: some View {
        MarketPage(viewModel: CryptoViewModel())
    }
}
