//
//  CryptoViewModel.swift
//  CryptoApp
//
//  Created by Eyüphan Akkaya on 7.08.2023.
//

import Foundation
import Firebase

class apiCaller {
    static let api = "https://api.coingecko.com/api/v3/"
}
class CryptoViewModel: ObservableObject {
    @Published var myList = [CoinModel]()
    @Published var favorites = [CoinModel]()
    @Published var myWallet = [WalletModel]()
    @Published var ref: DatabaseReference?
    @Published var user: Users?
    @Published var usersList = [Users]()
    @Published var signOutState = false
    
    
    @Published var totalWallet = 100.0
    
    func fetchAllCoin() {
        fetchCoinList { result in
            DispatchQueue.main.async {
                self.myList.append(contentsOf: result)
                
            }
        }
    }
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
    func fetchData() {
        if let user = Auth.auth().currentUser {
            let email = user.email
            if let mail = email {
                let ref = Database.database().reference()
                let dataRef = ref.child("users")
                
                dataRef.observeSingleEvent(of: .value, with: { snapshot in
                    if snapshot.exists() {
                        for case let childSnapshot as DataSnapshot in snapshot.children {
                            if let userData = childSnapshot.value as? [String: Any],
                               let name = userData["name"] as? String,
                               let surname = userData["surname"] as? String,
                               let userEmail = userData["mail"] as? String,
                               let password = userData["password"] as? String {
                                if userEmail == mail {
                                    let user = Users(email: userEmail, name: name, surname: surname, password: password)
                                    self.usersList.append(user)
                                }
                            }
                        }
                    } else {
                        print("Veri bulunamadı.")
                    }
                }) { error in
                    print("Hata oluştu: \(error.localizedDescription)")
                }
            }
        }
    }
    func signOut() {
        do {
            try  Auth.auth().signOut()
            signOutState = true
            print("çıkış yapıldı")
        } catch {
            print("Hata")
        }
    }
    
    func saveUser(name: String,surname: String,password: String,repeatPassword: String,mail: String){
        saveAuthUser(mail: mail, password: password)
        let dict:[String:Any] = ["name":name,"surname":surname,"password":password,"repeat_password":repeatPassword,"mail":mail]
        let newRef = ref?.child("users").childByAutoId()
        newRef?.setValue(dict)
        
    }
    func saveAuthUser(mail: String,password: String) {
        Auth.auth().createUser(withEmail: mail, password: password) { result, error in
            if error != nil {
                print(error)
            } else {
                print("Kayit olusturuldu")
            }
        }
    }

    func checkIfEmailExists(email: String, completion: @escaping (Bool) -> Void) {
       
        ref?.child("users").queryOrdered(byChild: "mail").queryEqual(toValue: email).observeSingleEvent(of: .value) { snapshot in
            if snapshot.exists() {
                completion(true)
            } else {
                completion(false)
            }
        }
    }

    
}
