//
//  LoginPageDesign.swift
//  CryptoApp
//
//  Created by Eyüphan Akkaya on 10.08.2023.
//

import SwiftUI
import FirebaseAuth

struct LoginPageDesign: View {
    @State var viewModel: CryptoViewModel
    @State private var mail = ""
    @State private var password =  ""
    @State var signInState = false
    @State private var isSecured: Bool = true
    @State private var showToAlerts: Bool = false
    @State private var alertsTitle = "Hata"
    @State private var alertsMessage = ""
    @State private var isEmailValid : Bool   = true
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
                    TextField("", text: $mail,onEditingChanged: { isChanged in
                        if !isChanged {
                            if textFieldValidatorEmail(mail) {
                                self.isEmailValid = true
                            } else {
                                self.isEmailValid = false
                                self.mail = ""
                            }
                        }
                    })
                    .padding(.leading,10)
                    .frame(width: 345,height: 42)
                    .border(Color("iconColors"))
                    .cornerRadius(8)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    
                    Text("Password")
                        .bold()
                    ZStack {
                        Group {
                            if isSecured {
                                SecureField("", text: $password)
                                    .padding(.leading,10)
                                    .frame(width: 345,height: 42)
                                    .border(Color("iconColors"))
                                    .textContentType(.password)
                                    .cornerRadius(8)

                            } else {
                                TextField("", text: $password)
                                    .padding(.leading,10)
                                    .frame(width: 345,height: 42)
                                    .border(Color("iconColors"))
                                    .textContentType(.password)
                                    .cornerRadius(8)

                            }
                        }
                        Button(action: {
                             isSecured.toggle()
                         }) {
                             Image(systemName: self.isSecured ? "eye.slash" : "eye")
                                 .accentColor(Color("iconColors"))
                                 
                         } .offset(x: 140)
                    }
                    
                }
                .padding()
                Button {
                    if mail.isEmpty || password.isEmpty{
                        showToAlerts = true
                        alertsTitle = "Boş bırakma"
                        alertsMessage = "Lütfen değerleri boş bırakmayınız."
                    } else if !textFieldValidatorEmail(mail) {
                        showToAlerts = true
                        alertsTitle = "Mail"
                        alertsMessage = "Lütfen mail formatını düzgün giriniz."
                    } else {
                        login()
                    }
                } label: {
                    Text("Login")
                        .foregroundColor(.white)
                }
                .alert(isPresented:$showToAlerts ) {
                    Alert(title: Text(alertsTitle),message: Text(alertsMessage),dismissButton: .cancel(Text("Tamam")))
                }
                .frame(width: 345, height: 38)
                .cornerRadius(8)
                .background(Color("iconColors"))
                .cornerRadius(4)
                .padding()
                
                if signInState {
                    withAnimation {
                        NavigationLink(destination: ContentView(viewModel: viewModel).navigationBarBackButtonHidden(true), isActive: $signInState) {
                            EmptyView()
                        }
                    }
                    
                }
                NavigationLink {
                    RegisterPageDesign(viewModel: viewModel).navigationBarBackButtonHidden(true)
                } label: {
                    Text("Don't Have an Account? Register here")
                        .foregroundColor(Color("iconColors"))
                }
                .frame(width: 345,height: 16)
                .font(.system(size: 12))    
            }
            
        }
        
    }
    
    func login()  {
        Auth.auth().signIn(withEmail: mail, password: password) { result, error in
            if error != nil {
                print(error)
                showToAlerts = true
                alertsTitle = "Hata"
                alertsMessage = "Lütfen geçerli mail şifre giriniz."
            } else {
                signInState = true
            }
        }
    }
    
    
    struct LoginPageDesign_Previews: PreviewProvider {
        static var previews: some View {
            LoginPageDesign(viewModel: CryptoViewModel())
        }
    }
}
