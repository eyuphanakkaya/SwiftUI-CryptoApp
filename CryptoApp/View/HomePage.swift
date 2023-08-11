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
    @State var money = 25000.0
    var body: some View {
        NavigationView{
           
            VStack{
                ZStack {
                    VStack(alignment: .leading) {
                        Text("Total Portfolio")
                            .frame(width: 115,height: 20)
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                        Text("$56.98")
                            .frame(width: 115,height: 40)
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
               
                ScrollView(.horizontal){
                    HStack {
                        ZStack{
                            Image("background")
                            .frame(width: 191,height: 120)
                            .cornerRadius(24)
                            VStack {
                                HStack{
                                    Image("bitcoin")
                                        .resizable()
                                        .frame(width: 40,height: 40)
                                    VStack(alignment: .leading) {
                                        Text("BTC")
                                        Text("Bitcoin")
                                    }
                                    ZStack {
                                        Rectangle()
                                            .foregroundColor(Color(.gray))
                                            .frame(width: 55,height: 22)
                                            .cornerRadius(8)
                                        Text("+15.3%")
                                            .font(.system(size: 10))
                                            .foregroundColor(.white)
                                    }
                                    
                                }
                                Rectangle()
                                    .frame(width: 159,height: 1)
                                    .foregroundColor(.gray)
                                HStack {
                                    Text("$26.46")
                                        .frame(width: 50,height: 18)
                                        .font(.system(size: 14))
                                        .padding(.leading,10)
                                    Spacer()
                                    Text("0.0012BTC")
                                        .frame(width: 55,height: 12)
                                        .font(.system(size: 10))
                                        .padding(.trailing,10)
                                }
                            }
                          
                            
                           
                        }

                    }
                    .padding()
                }
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
