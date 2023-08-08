//
//  HomePageDesign.swift
//  CryptoApp
//
//  Created by Eyüphan Akkaya on 8.08.2023.
//

import SwiftUI
import Kingfisher

struct HomePageDesign: View {
    @State var coin: CoinModel
    var body: some View {
        VStack {
            HStack {
                if let resim = coin.image{
                    KFImage(URL(string: resim ))
                        .resizable()
                        .frame(width: 56, height: 56)
                }

                VStack {
                    Text("\(coin.symbol ?? "")".uppercased())
                    if let yuzde = coin.price_change_percentage_24h {
                        if yuzde > 0 {
                            Text("+\(yuzde.asNumberString())")
                                .foregroundColor(.gray)
                        } else {
                            Text("\(yuzde.asNumberString())")
                                .foregroundColor(.gray)
                        }
                       
                    }
                  
                }
                Image("grafik")
                    .resizable()
                    .frame(width: 84,height: 37)
                VStack {
                    Text("\(coin.current_price.asCurrencyWith6Decimals())")
                        .frame(width: 91,height: 24)
                        .font(.system(size: 17))
                    Text("2.73 \(coin.symbol ?? "")")
                            .foregroundColor(.gray)
                            .frame(width: 70,height: 20)
                    

                }
              
            }
        }

        
    }
}


