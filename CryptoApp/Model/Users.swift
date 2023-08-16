//
//  Users.swift
//  CryptoApp
//
//  Created by Eyüphan Akkaya on 16.08.2023.
//

import Foundation
 
struct Users: Identifiable {
    var id: String = UUID().uuidString
    let email: String
    let name: String
    let surname: String
    let password: String
}
