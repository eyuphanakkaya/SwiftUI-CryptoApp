//
//  Wallet.swift
//  CryptoApp
//
//  Created by Eyüphan Akkaya on 14.08.2023.
//

import Foundation

struct WalletModel: Identifiable {
    var id: String?
    let image: String?
    let title: String?
    let subtitle: String?
    var amount: Double?
    var price: Double?
    var priceChange: Double?
}
