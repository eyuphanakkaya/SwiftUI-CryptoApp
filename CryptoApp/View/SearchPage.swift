//
//  SearchPage.swift
//  CryptoApp
//
//  Created by Eyüphan Akkaya on 10.08.2023.
//

import SwiftUI
import Kingfisher

struct SearchPage: View {
    @State var coin: Coin?
    @State var coinModel: CoinModel?
    var body: some View {
        VStack {
            
                HStack {
                    if let resim = coin?.large{
                        KFImage(URL(string: resim ))
                            .resizable()
                            .frame(width: 56, height: 56)

                    }
                    VStack {
                        Text("\(coin?.symbol ?? "")".uppercased())
                        if let yuzde = coinModel?.price_change_percentage_24h {
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
                        Text("\(coinModel?.current_price.asCurrencyWith6Decimals() ?? "")")
                            .frame(width: 91,height: 24)
                            .font(.system(size: 17))
                        Text("2.73 \(coin?.symbol ?? "")")
                                .foregroundColor(.gray)
                                .frame(width: 70,height: 20)
                        
                    }
                  
                }
            

          
        }
        .padding()
        .frame(width: 343,height: 88)
        .background(.white)
        .cornerRadius(10)
    }
}

struct SearchPage_Previews: PreviewProvider {
    static var previews: some View {
        SearchPage()
    }
}
