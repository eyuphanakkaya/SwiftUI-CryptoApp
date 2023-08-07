//
//  CryptoViewModel.swift
//  CryptoApp
//
//  Created by Eyüphan Akkaya on 7.08.2023.
//

import Foundation


class CryptoViewModel: ObservableObject {
    //@Published var coinList: CoinModel
    class apiCaller {
       static let api = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=50&page=1&sparkline=true&price_change_percentage=24&locale=en"
    }
    
    func fetchCoinList() {
        let url = URL(string: (apiCaller.api))
        if let comingUrl = url {
            URLSession.shared.dataTask(with: comingUrl) { data, response, error in
                guard error != nil || data != nil else{
                    print(error)
                    return
                }
                do {
                    let result = try JSONDecoder().decode([CoinModel].self, from: data!)
                    print(result)
                } catch {
                    print(error)
                }
            }.resume()
        }
        
    }
    
}