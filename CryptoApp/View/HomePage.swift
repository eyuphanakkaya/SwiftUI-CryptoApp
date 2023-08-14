//
//  HomePage.swift
//  CryptoApp
//
//  Created by Eyüphan Akkaya on 7.08.2023.
//

import SwiftUI
import Kingfisher

struct HomePage: View {
    @ObservedObject var viewModel: CryptoViewModel
    @State var coinList = [CoinModel]()
    @State var coin: CoinModel?

    var body: some View {
        NavigationView{
           
            VStack{
                ZStack {
                    VStack(alignment: .leading) {
                        Text("Total Portfolio")
                            .frame(width: 115,height: 20)
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                        Text("\(viewModel.totalWallet.asCurrencyWith6Decimals())")
                            .frame(width: 160,height: 40)
                            .font(.system(size: 32))
                            .foregroundColor(.white)
                            .bold()
                    }
                    .padding(.leading,-150)
                    
                
                ZStack {
                    Rectangle()
                        .foregroundColor(Color(.white))
                        .frame(width: 75,height: 32)
                        .cornerRadius(8)
                    Text("+15.3%")
                        .font(.system(size: 10))
                        .frame(width: 40,height: 15)
                        .foregroundColor(Color("iconColors"))
                }
                .offset(x:120)
                    
                }
                .frame(width: 345,height: 112)
                .cornerRadius(12)
                .background(Color("iconColors"))
                .cornerRadius(20)
                .padding(.top,20)

                WalletPage(viewModel: viewModel)
                HStack {
                    Text("Charts")
                        .padding()
                        .foregroundColor(.gray)
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("See All")
                            .padding()
                            .foregroundColor(Color("iconColors"))
                    }
                }

                ScrollView{
                        ForEach(coinList.prefix(4)) { list in
                            NavigationLink(destination: DetailPage(viewModel: viewModel,coin: list, coinList: coinList, fav: false)) {
                                HomePageDesign(coin: list)
                            }
                        }
                    }
                
            }

            .navigationTitle("Portfolio")
            .background(Color("background"))
        }
        .onAppear{
            viewModel.fetchCoinList { result in
                self.coinList.append(contentsOf: result)
//                for x in result {
//                   // print("\(x.sparkline_in_7d?.price)")
//                }
            }
            
            
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage(viewModel: CryptoViewModel())
    }
}
