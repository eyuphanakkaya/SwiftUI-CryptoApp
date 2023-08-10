//
//  RegisterPageDesign.swift
//  CryptoApp
//
//  Created by Eyüphan Akkaya on 10.08.2023.
//

import SwiftUI

struct RegisterPageDesign: View {
    @State var registerMail = ""
    @State var registerName = ""
    @State var registerSurname = ""
    @State var registerPassword: Int
    @State var registerRepaetPassword: Int
    var body: some View {
        VStack{
            HStack {
                Image("logo")
                    .resizable()
                    .frame(width: 48,height: 43)
                Text("Crypto")
                    .frame(width: 110,height: 21)
                    .font(.system(size: 25))
                    .bold()
            }.offset(y: -50)
            VStack {
                Text("Welcome to Register")
                     .frame(width: 330,height: 40 )
                     .font(.system(size: 32))
                     .bold()
                 Text("Trusted by millions of users worldwide")
                     .frame(width: 330,height: 18)
                     .font(.system(size: 14))
                     .foregroundColor(Color("iconColors"))
            }.offset(y: -30)
            VStack(alignment: .leading,spacing: 10) {
                Text("Email")
                    .bold()
                TextField("", text: $registerMail)
                    .padding(.leading,10)
                    .frame(width: 345,height: 42)
                    .border(Color("iconColors"))
                    .cornerRadius(8)
                Text("Name")
                    .bold()
                TextField("", text: $registerName)
                    .padding(.leading,10)
                    .frame(width: 345,height: 42)
                    .border(Color("iconColors"))
                    .cornerRadius(8)
                Text("Surname")
                    .bold()
                TextField("", text: $registerSurname)
                    .padding(.leading,10)
                    .frame(width: 345,height: 42)
                    .border(Color("iconColors"))
                    .cornerRadius(8)
                    
                Text("Password")
                    .bold()
               TextField("", value: $registerPassword, formatter: NumberFormatter())
                    .padding(.leading,10)
                    .frame(width: 345,height: 42)
                    .border(Color("iconColors"))
                    .cornerRadius(8)
                Text("Repeat Password")
                    .bold()
               TextField("", value: $registerRepaetPassword, formatter: NumberFormatter())
                    .padding(.leading,10)
                    .frame(width: 345,height: 42)
                    .border(Color("iconColors"))
                    .cornerRadius(8)
                    
            }
            .padding()
            Button {
                
            } label: {
                Text("Create")
                    .foregroundColor(.white)
            }
            .frame(width: 345,height: 38)
            .cornerRadius(8)
            .background(Color("iconColors"))
            .cornerRadius(4)
            .padding()
            Button {
                
            } label: {
                Text("Already have an account? Enter here")
                    .foregroundColor(Color("iconColors"))
            }
            .frame(width: 345,height: 16)
            .font(.system(size: 12))
        }
    }
}

struct RegisterPageDesign_Previews: PreviewProvider {
    static var previews: some View {
        RegisterPageDesign(registerPassword: 1, registerRepaetPassword: 1)
    }
}
