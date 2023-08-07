//
//  HomePage.swift
//  CryptoApp
//
//  Created by Eyüphan Akkaya on 7.08.2023.
//

import SwiftUI

struct HomePage: View {
    @ObservedObject var viewModel = CryptoViewModel()
    var body: some View {
        NavigationView{
           
            VStack{
                ScrollView(.horizontal){
                    HStack {
                        ZStack{
                            Image("background")
                            .frame(width: 320,height: 180)
                            .cornerRadius(24)
                                HStack{
                                    VStack {
                                        Text("$49,349.77")
                                            .font(.system(size: 28))
                                            .bold()
                                            .foregroundColor(.white)
                                            .offset(y: -30)
                                            .padding()
                                        Text("Your balance is equivalet")
                                            .offset(y: -40)
                                            .foregroundColor(.white)
                                            .padding(.leading,20)
                                        

                                    }
                                   
                                    Spacer()
                                    Image("bitcoin")
                                        .offset(y: -50)
                                        .padding()
                                
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
                            .foregroundColor(.red)
                    }

                }
                ScrollView{
                    VStack {
                        HStack {
                            Image("btc")
                                .resizable()
                                .frame(width: 56,height: 56)
                            VStack {
                                Text("BTC")
                                Text("+1.6%")
                                    .foregroundColor(.gray)
                            }
                            Image("grafik")
                                .resizable()
                                .frame(width: 84,height: 37)
                            VStack {
                                Text("$29.850.15")
                                    .frame(width: 91,height: 24)
                                    .font(.system(size: 17))
                                Text("2.73 BTC")
                                    .foregroundColor(.gray)
                                    .frame(width: 70,height: 20)
                            }
                          
                        }
                    }
                }
            }

            .navigationTitle("Portfolio")
            .toolbar{
                ToolbarItem {
                    Image(systemName: "heart")
                }
            }
        }

        .onAppear{
            viewModel.fetchCoinList()
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
