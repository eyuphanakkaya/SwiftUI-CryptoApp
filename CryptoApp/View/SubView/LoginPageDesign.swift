//
//  LoginPageDesign.swift
//  CryptoApp
//
//  Created by Eyüphan Akkaya on 10.08.2023.
//

import SwiftUI

struct LoginPageDesign: View {
    @State private var mail = ""
    @State  var password: Int
    var body: some View {
        
        NavigationView {
            VStack {
                HStack {
                    Image("logo")
                        .resizable()
                        .frame(width: 48,height: 43)
                    Text("Crypto")
                        .frame(width: 110,height: 21)
                        .font(.system(size: 25))
                        .bold()
                }.offset(y: -120)
                VStack {
                    Text("Welcome to Login")
                         .frame(width: 330,height: 40 )
                         .font(.system(size: 32))
                         .bold()
                     Text("Trusted by millions of users worldwide")
                         .frame(width: 330,height: 18)
                         .font(.system(size: 14))
                         .foregroundColor(Color("iconColors"))
                }.offset(y: -50)
                VStack(alignment: .leading,spacing: 10) {
                    Text("Email")
                        .bold()
                    TextField("", text: $mail)
                        .padding(.leading,10)
                        .frame(width: 345,height: 42)
                        .border(Color("iconColors"))
                        .cornerRadius(8)
                        
                    Text("Password")
                        .bold()
                   TextField("", value: $password, formatter: NumberFormatter())
                        .padding(.leading,10)
                        .frame(width: 345,height: 42)
                        .border(Color("iconColors"))
                        .cornerRadius(8)
                        
                }
                .padding()
                Button {
                    
                } label: {
                    Text("Login")
                        .foregroundColor(.white)
                }
                .frame(width: 345,height: 38)
                .cornerRadius(8)
                .background(Color("iconColors"))
                .cornerRadius(4)
                .padding()
                NavigationLink {
                    RegisterPageDesign(registerPassword: 1, registerRepaetPassword: 1)
                } label: {
                    Text("Don't Have an Account? Register here")
                        .foregroundColor(Color("iconColors"))
                }
                .frame(width: 345,height: 16)
                .font(.system(size: 12))

                



                
            }
        }
      
    }
}

struct LoginPageDesign_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageDesign(password: 0)
    }
}
