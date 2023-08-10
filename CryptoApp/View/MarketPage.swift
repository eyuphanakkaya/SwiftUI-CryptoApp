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
    @State var searchList = [CoinSearch]()
    @State var coin: CoinSearch?
    @State var selectedItem = true
    var searchResult: [CoinSearch] {
        return searchList.filter{$0.name!.localizedCaseInsensitiveContains(search)}
    }
    @ObservedObject var viewModel: CryptoViewModel
    
    var body: some View {
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
            NavigationStack {
                if search.isEmpty && selectedItem == true {
                    VStack{
                        ScrollView{
                            ForEach(viewModel.myList) { list in
                                NavigationLink(destination: DetailPage(viewModel: viewModel,coin: list, fav: false)) {
                                    HomePageDesign(coin: list)
                                }
                             
                            }
                        }
                        .frame(width: 345,height: 550)
                        .padding()
                        
                    }
                    .background(Color("background"))
                } else if search.isEmpty && selectedItem == false {
                    VStack{
                        ScrollView{
                            ForEach(viewModel.favorites) { list in
                                NavigationLink(destination: DetailPage(viewModel: viewModel,coin: list, fav: false)) {
                                    HomePageDesign(coin: list)
                                }
                             
                            }
                        }
                        .frame(width: 345,height: 550)
                        .padding()
                        
                    }
                    .background(Color("background"))
                } else {
                    VStack{
                        ScrollView{
                            ForEach(searchResult) { list in
                                SearchPage(coin: list)
//                                NavigationLink(destination: DetailPage(viewModel: viewModel,coin: list, fav: false)) {
//                                   SearchPage(coin: list)
//                                }
                             
                            }
                        }
                        .frame(width: 345,height: 550)
                        .padding()
                        
                    }
                    .background(Color("background"))
                }

            }
            .searchable(text: $search,prompt: "Search Coin")
            .onChange(of: search) { newSearch in
                viewModel.fetchSearchCoin(searchCoin: newSearch) { result in
                    searchList.append(contentsOf: result)
                    print("yeniii ARAMAAAA =\(newSearch)")
                    print("sonucccc =\(result)")
                    print("ARAMAAAA =\(searchList)")
                }
            }
            .onAppear{
                viewModel.fetchAllCoin()
              
            }
        }


       

    }

}

struct MarketPage_Previews: PreviewProvider {
    static var previews: some View {
        MarketPage(viewModel: CryptoViewModel())
    }
}
