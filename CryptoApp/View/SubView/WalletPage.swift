//
//  WalletPage.swift
//  CryptoApp
//
//  Created by Eyüphan Akkaya on 14.08.2023.
//

import SwiftUI
import Kingfisher

struct WalletPage: View {
    @ObservedObject var viewModel: CryptoViewModel
    var body: some View {
        
         ScrollView(.horizontal){
             HStack {
                 ForEach(viewModel.myWallet) { wallet in
                     ZStack{

                         VStack {
                             HStack{
                                 if let image = wallet.image {
                                    KFImage(URL(string: image))
                                         .resizable()
                                         .frame(width: 40,height: 40)
                                 }

                                 VStack(alignment: .leading) {
                                     Text(wallet.title ?? "")
                                     Text(wallet.subtitle ?? "")
                                 }
                                 ZStack {
                                     Rectangle()
                                         .foregroundColor(Color(.gray))
                                         .frame(width: 55,height: 22)
                                         .cornerRadius(8)
                                     Text("\((wallet.priceChange ?? 0).asNumberString())")
                                         .font(.system(size: 10))
                                         .foregroundColor(.white)
                                 }
                                 
                             }
                             Rectangle()
                                 .frame(width: 159,height: 1)
                                 .foregroundColor(.gray)
                             HStack {
                                 Text("Fiyat")
                                 Text("\((wallet.price ?? 0).asCurrencyWith6Decimals())")
                                     .frame(width: 60,height: 18)
                                     .font(.system(size: 14))
                                     .padding(.leading,10)
                                 Spacer()
                                 Text("Miktar")
                                 Text("\((wallet.amount ?? 0).asNumberString())")
                                     .frame(width: 55,height: 12)
                                     .font(.system(size: 10))
                                     .padding(.trailing,10)
                             }
                         }
                         
                         
                         
                     }
                     .frame(width: 191,height: 130)
                     .background(Color.white)
                     .cornerRadius(24)
                 }

             }
             .padding()
         }
    }
}

struct WalletPage_Previews: PreviewProvider {
    static var previews: some View {
        WalletPage(viewModel: CryptoViewModel())
    }
}
