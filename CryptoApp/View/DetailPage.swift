//
//  DetailPage.swift
//  CryptoApp
//
//  Created by Eyüphan Akkaya on 9.08.2023.
//

import SwiftUI
import Kingfisher

struct DetailPage: View {
    @ObservedObject var viewModel: CryptoViewModel
    @State var coin: CoinModel?
    @State var coinList: [CoinModel]?
    @State private var buyOrSell  = 0
    @State var fav: Bool
    @State var estimatedValue:Double = 0.0
    @State var tradeValue:Double = 0.0
    @State var tradeFee:Double = 0.0
    @State var sonuc = 0.0
    
    func hesapla()-> Double{
        let hesap = tradeFee / estimatedValue
        sonuc = hesap
        return sonuc
    }
    var body: some View {
        
        LazyVStack {
            if let image = coin?.image,
               let symbol = coin?.symbol,
               let name = coin?.id,
               let currentPrice = coin?.current_price  {
                LazyHStack {
                    KFImage(URL(string: image))
                        .resizable()
                        .frame(width: 56,height: 56)
                    VStack(alignment: .leading) {
                        Text(symbol.uppercased())
                            .bold()
                        Text(name)
                    }
                    VStack {
                        
                    }
                    .frame(width: 140,height: 84)
                    VStack(alignment: .trailing) {
                        Text("\(currentPrice.asCurrencyWith6Decimals())")
                            .bold()
                            .frame(width: 100)
                        Text("1 \(symbol.uppercased())")
                            .foregroundColor(.gray)
                            .padding(.trailing,10)
                        
                    }
                    .frame(width: 90,height: 45)
                }
                
                
                if let coins = coin,let high = coin?.high_24h,let low = coin?.low_24h {
                    CoinGraph(coin: coins)
                        .frame(width: 375,height: 254)
                        .overlay(VStack{
                            Text("\(high.asCurrencyWith6Decimals())")
                            Spacer()
                            Text("\(((high + low) / 2).asCurrencyWith6Decimals() )")
                            Spacer()
                            Text("\(low.asCurrencyWith6Decimals())")
                        },alignment: .leading)
                }
                
                
                
                Picker("", selection: $buyOrSell) {
                    Text("Buy").tag(0)
                    Text("Sell").tag(1)
                }.pickerStyle(.segmented)
                    .frame(width: 335,height: 32)
                    .background(Color("iconColors2"))
                ScrollView {
                    //tahmini satın alma değeri Estimated purchase value
                    VStack {
                        Text("tahmini satın alma değeri")
                            .foregroundColor(.gray)
                            .offset(x:-90)
                        TextField("", value: $estimatedValue, formatter: NumberFormatter())
                            .padding(.leading,10)
                            .onChange(of: estimatedValue) { newValue in
                                tradeValue = hesapla()
                            }
                        Rectangle()
                            .frame(width: 370,height: 1)
                            .foregroundColor(.gray)
                            .offset(y:-10)
                    }
                    VStack {
                        //ticari değer Trade Value
                        Text("ticari değer")
                            .foregroundColor(.gray)
                            .offset(x:-140)
                        TextField("", value: $tradeValue, formatter: NumberFormatter())
                            .padding(.leading,10)
                            
                        Rectangle()
                            .frame(width: 370,height: 1)
                            .foregroundColor(.gray)
                            .offset(y:-10)
                    }
                    VStack {
                        //ticaret ücreti Trade Fee
                        Text("ticaret ücreti")
                            .foregroundColor(.gray)
                            .offset(x:-145)
                        TextField("", value: $tradeFee, formatter: NumberFormatter())
                            .padding(.leading,10)
                            .onChange(of: tradeFee) { newValue in
                                tradeValue = hesapla()
                            }
                        Rectangle()
                            .frame(width: 370,height: 1)
                            .foregroundColor(.gray)
                            .offset(y:-10)
                    }
                    .padding(.top,10)
                    if buyOrSell == 0 {
                        Button {
                            print(hesapla())
                        } label: {
                            Text("Buy")
                            
                        }
                        .frame(width: 200,height: 50)
                        .background(Color("iconColors"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        
                    } else {
                        Button {
                            print("Satıldı")
                        } label: {
                            Text("Sell")
                        }
                        .frame(width: 200,height: 50)
                        .background(Color("iconColors2"))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                    }
                    
                }
            }
        }
        .onAppear{
            if viewModel.favorites.contains(where: {$0.id ?? "" == coin?.id }) {
                fav = true
            } else {
                fav = false
            }
            estimatedValue = coin?.current_price ?? 0
        }
        .toolbar {
            ToolbarItem{
                Button {
                    if let myCoin = coin {
                        fav.toggle()
                        if fav {
                            viewModel.favorites.append(myCoin)
                            
                        } else {
                            
                            if let removeCoin = viewModel.favorites.firstIndex(of: myCoin) {
                                viewModel.favorites.remove(at: removeCoin)
                                
                            }
                        }
                    }
                    
                } label: {
                    if fav {
                        Image(systemName: "heart.fill")
                            .resizable()
                            .frame(width: 20,height: 20)
                    } else {
                        Image(systemName: "heart")
                            .resizable()
                            .frame(width: 20,height: 20)
                    }
                }
            }
        }
        
    }
}

struct DetailPage_Previews: PreviewProvider {
    static var previews: some View {
        DetailPage(viewModel: CryptoViewModel(), fav: false)
    }
}
