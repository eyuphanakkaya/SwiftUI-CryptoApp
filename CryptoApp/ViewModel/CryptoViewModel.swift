//
//  CryptoViewModel.swift
//  CryptoApp
//
//  Created by Eyüphan Akkaya on 7.08.2023.
//

import Foundation

class apiCaller {
    static let api = "https://api.coingecko.com/api/v3/"
}
class CryptoViewModel: ObservableObject {
    @Published var myList = [CoinModel]()
    @Published var favorites = [CoinModel]()
    
    func fetchAllCoin() {
        fetchCoinList { result in
            DispatchQueue.main.async {
                self.myList.append(contentsOf: result)

            }
        }
    }
//    func fetchAllSearch(search: String) {
//        fetchSearchList(search: search) { result in
//            self.searchList.append(contentsOf: result)
//        }
//    }
    //https://api.coingecko.com/api/v3/search?query=bitcoin
    //https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=50&page=1&sparkline=true&price_change_percentage=24&locale=en
    

    func fetchSearchCoin(searchCoin: String,completion: @escaping([Coin])-> Void) {
        let url = URL(string: "https://api.coingecko.com/api/v3/search?query=\(searchCoin)")
        if let incomingUrl = url {
            URLSession.shared.dataTask(with: incomingUrl) { data, response, error in
                guard error != nil || data != nil else{return}
                do {
                    let result = try JSONDecoder().decode(CoinSearchResult.self, from: data!)
                    print(searchCoin)
                    DispatchQueue.main.async {
                        completion(result.coins ?? [])
                    }
                } catch {
                    print(error)
                }
            }.resume()
        }
    }
    
    func fetchCoinList(completion: @escaping([CoinModel]) -> Void) {
        let url = URL(string: "\(apiCaller.api)coins/markets?vs_currency=usd&order=market_cap_desc&per_page=50&page=1&sparkline=true&price_change_percentage=24&locale=en")
        if let comingUrl = url {
            URLSession.shared.dataTask(with: comingUrl) { data, response, error in
                guard error != nil || data != nil else{
                    print(error)
                    return
                }
                do {
                    let result = try JSONDecoder().decode([CoinModel].self, from: data!)
                    completion(result)
                } catch {
                    print(error)
                }
            }.resume()
        }
        
    }
    func fetchCoinCharts(id: String,completion: @escaping(CoinCharts)-> Void) {
        let url = URL(string: "\(apiCaller.api)coins/\(id)/market_chart?vs_currency=usd&days=7&interval=daily&precision=2")
        if let comingUrl = url {
            URLSession.shared.dataTask(with: comingUrl) { data, response, error in
                guard data != nil || error != nil else{
                    print(error)
                    return
                }
                do{
                    let result = try JSONDecoder().decode(CoinCharts.self, from: data!)
                    completion(result)
                } catch {
                    print(error)
                }
            }.resume()
        }
    }
    
}
