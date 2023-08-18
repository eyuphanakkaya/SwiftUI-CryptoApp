//
//  MarketPage.swift
//  CryptoApp
//
//  Created by Eyüphan Akkaya on 8.08.2023.
//

import SwiftUI
import Charts

struct MarketPage: View {
    @State var search = ""
    @State var searchList = [Coin]()
    @State var coin: CoinSearchResult?
    @State var selectedItem = true
    var searchResult: [Coin] {
        return searchList.filter{$0.name.localizedCaseInsensitiveContains(search)}
    }
    @ObservedObject var viewModel: CryptoViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button {
                        withAnimation {
                            selectedItem = true
                            
                        }
                        print("Hepsi")
                    } label: {
                        
                        Text("All")
                            .foregroundColor(selectedItem ? Color.white : Color("iconColors"))
                    }
                    .frame(width: 80,height: 30)
                    .border(.gray)
                    .background(selectedItem ?  Color("iconColors") : Color.clear)
                    .cornerRadius(5)
                    .padding(.leading,10)
                    
                    Button {
                        withAnimation {
                            selectedItem = false
                        }
                        print("Favoriler")
                    } label: {
                        Text("Favorites")
                            .foregroundColor(selectedItem ? Color("iconColors") : Color.white)
                    }
                    .frame(width: 100,height: 30)
                    .background(selectedItem ? Color.clear : Color("iconColors") )
                    .border(.gray)
                    .cornerRadius(5)
                    .padding(.leading,10)
                }
                .padding(.top,50)

                ScrollView{
                    if search.isEmpty && selectedItem == true {
                        VStack{
                            ForEach(viewModel.myList) { list in
                                NavigationLink(destination: DetailPage(viewModel: viewModel,coin: list, fav: false)) {
                                    HomePageDesign(coin: list)
                                }
                            }
                            
                            
                        }
                        .background(Color("background"))
                    } else if search.isEmpty && selectedItem == false {
                        VStack{
                                ForEach(viewModel.favorites) { list in
                                    NavigationLink(destination: DetailPage(viewModel: viewModel,coin: list, fav: false)) {
                                        HomePageDesign(coin: list)
                                    }
                            }

                            
                        }
               
                        .background(Color("background"))
                    } else {
                        VStack{
                                ForEach(searchResult.prefix(10),id: \.hashValue) { list in
                                    ForEach(viewModel.myList.prefix(10)) { liste in
                                        NavigationLink(destination: DetailPage(viewModel: viewModel,coin: liste, fav: false)) {
                                            SearchPage(coin: list,coinModel: liste)
                                        }
                                    }
                            }
                        }
                    }
                }
                .frame(width: 345,height: 600)
                .padding()
            }
            .padding()
            .background(Color("background"))
        }
        
        .searchable(text: $search)
        .onChange(of: search) { newSearch in
            viewModel.fetchSearchCoin(searchCoin: newSearch) { result in
                searchList.append(contentsOf: result)
            }
        }
        .onAppear{
            viewModel.fetchAllCoin()
        }
    }
    
}

struct MarketPage_Previews: PreviewProvider {
    static var previews: some View {
        MarketPage(viewModel: CryptoViewModel())
    }
}
