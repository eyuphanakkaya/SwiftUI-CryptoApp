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
    @State var searchList = [CoinModel]()
    @State var coin: CoinModel?
    @State var selectedItem = true
    var searchResult: [CoinModel] {
        return searchList.filter{$0.symbol!.localizedCaseInsensitiveContains(search)}
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
                if search.isEmpty {
                    VStack{
                        ScrollView{
                            ForEach(viewModel.myList) { list in
                                NavigationLink(destination: DetailPage(viewModel: viewModel,coin: list)) {
                                    HomePageDesign(coin: list)
                                }
                             
                            }
                        }
                        .frame(width: 345,height: 550)
                        .padding()
                        
                    }
                    .background(Color("background"))
                } else if !search.isEmpty{
                    VStack{
                        ScrollView{
                            ForEach(searchResult) { list in
                                NavigationLink(destination: DetailPage(viewModel: viewModel,coin: list)) {
                                    HomePageDesign(coin: list)
                                }
                             
                            }
                        }
                        .frame(width: 345,height: 550)
                        .padding()
                        
                    }
                    .background(Color("background"))
                }

            }
            .searchable(text: $search)
            .onChange(of: search, perform: { newSearch in
                    viewModel.fetchSearchList(search: newSearch) { result in
                        print(result)
                        self.searchList.append(contentsOf: result)
                    }
                })
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
