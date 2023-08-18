//
//  RegisterPageDesign.swift
//  CryptoApp
//
//  Created by Eyüphan Akkaya on 10.08.2023.
//

import SwiftUI
import Firebase

struct RegisterPageDesign: View {
    @State var viewModel: CryptoViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var registerMail = ""
    @State var registerName = ""
    @State var registerSurname = ""
    @State var registerPassword = ""
    @State var registerRepaetPassword = ""
    @State private var isEmailValid : Bool   = true
    @State private var isSecured: Bool = true
    @State private var showToAlerts: Bool = false
    @State private var alertsTitle = "Hata"
    @State private var alertsMessage = ""
    @State var usersControlList = [String]()
  
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
                
                TextField("", text: $registerMail,onEditingChanged: { isChanged in
                    if !isChanged {
                        if self.textFieldValidatorEmail(self.registerMail) {
                            self.isEmailValid = true
                        } else {
                            self.isEmailValid = false
                            self.registerMail = ""
                        }
                    }
                })
                .padding(.leading,10)
                .frame(width: 345,height: 42)
                .border(Color("iconColors"))
                .cornerRadius(8)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                
                Text("Name")
                    .bold()
                TextField("", text: $registerName)
                    .padding(.leading,10)
                    .frame(width: 345,height: 42)
                    .border(Color("iconColors"))
                    .cornerRadius(8)
                    .textContentType(.name)
                    .onChange(of: registerName, perform: { newValue in
                        let filteredValue = newValue.filter { character in
                            CharacterSet.letters.contains(UnicodeScalar(String(character))!) || character == " "
                        }
                        self.registerName = filteredValue
                        if newValue.count > 20 {
                            self.registerName = String(newValue.prefix(25))
                        }
                    })
                
                Text("Surname")
                    .bold()
                TextField("", text: $registerSurname)
                    .padding(.leading,10)
                    .frame(width: 345,height: 42)
                    .border(Color("iconColors"))
                    .cornerRadius(8)
                    .textContentType(.name)
                    .onChange(of: registerSurname, perform: { newValue in
                        let filteredValue = newValue.filter { character in
                            CharacterSet.letters.contains(UnicodeScalar(String(character))!) || character == " "
                        }
                        self.registerSurname = filteredValue
                        if newValue.count > 20 {
                            self.registerSurname = String(newValue.prefix(25))
                        }
                    })
                
                Text("Password")
                    .bold()
                ZStack {
                    Group {
                        if isSecured {
                            SecureField("", text: $registerPassword)
                                .padding(.leading,10)
                                .frame(width: 345,height: 42)
                                .border(Color("iconColors"))
                                .cornerRadius(8)
                                .textContentType(.password)
                                .keyboardType(.numberPad)
                        } else {
                            TextField("", text: $registerPassword)
                                .padding(.leading,10)
                                .frame(width: 345,height: 42)
                                .border(Color("iconColors"))
                                .cornerRadius(8)
                                .textContentType(.password)
                                .keyboardType(.numberPad)
                        }
                    }
                    Button(action: {
                        isSecured.toggle()
                    }) {
                        Image(systemName: self.isSecured ? "eye.slash" : "eye")
                            .accentColor(Color("iconColors"))
                        
                    } .offset(x: 140)
                }
                Text("Repeat Password")
                    .bold()
                ZStack {
                    Group {
                        if isSecured {
                            SecureField("", text: $registerRepaetPassword)
                                .padding(.leading,10)
                                .frame(width: 345,height: 42)
                                .border(Color("iconColors"))
                                .cornerRadius(8)
                                .textContentType(.password)
                                .keyboardType(.numberPad)
                        } else {
                            TextField("", text: $registerRepaetPassword)
                                .padding(.leading,10)
                                .frame(width: 345,height: 42)
                                .border(Color("iconColors"))
                                .cornerRadius(8)
                                .textContentType(.password)
                                .keyboardType(.numberPad)
                        }
                    }
                    Spacer()
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
                if registerName.isEmpty || registerMail.isEmpty || registerSurname.isEmpty || registerPassword.isEmpty || registerRepaetPassword.isEmpty  {
                    showToAlerts = true
                    alertsTitle = "Boş bırakma"
                    alertsMessage = "Lütfen değerleri boş bırakmayınız."
                } else if registerPassword != registerRepaetPassword {
                    showToAlerts = true
                    alertsTitle = "Şifre"
                    alertsMessage = "Lütfen şifreleri aynı giriniz."
                } else if !textFieldValidatorEmail(registerMail) {
                    showToAlerts = true
                    alertsTitle = "Mail"
                    alertsMessage = "Lütfen mail formatını düzgün giriniz."
                } else {
                    viewModel.checkIfEmailExists(email: registerMail) { result in
                        if result {
                            showToAlerts = true
                            alertsTitle = "Hata"
                            alertsMessage = "Bu mail adresi mevcut lütfen farklı bir adres giriniz."
                        } else {
                            viewModel.saveUser(name: registerName, surname: registerSurname, password: registerPassword, repeatPassword: registerRepaetPassword, mail: registerMail)
                            showToAlerts = true
                            alertsTitle = "Başarılı"
                            alertsMessage = "Kayıt başarıyla oluşturuldu."
                        }
                    }
                   
                }
                
            } label: {
                Text("Create")
                    .foregroundColor(.white)
            }
            .alert(isPresented: $showToAlerts) {
                Alert(title: Text(alertsTitle),message: Text(alertsMessage),dismissButton: .cancel(Text("Tamam")))
            }
            .frame(width: 345,height: 38)
            .cornerRadius(8)
            .background(Color("iconColors"))
            .cornerRadius(4)
            .padding()
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Already have an account? Enter here")
                    .foregroundColor(Color("iconColors"))
            }
            .frame(width: 345,height: 16)
            .font(.system(size: 12))
        }.onAppear{
            viewModel.ref = Database.database().reference()
            
        }
    }

    
}

struct RegisterPageDesign_Previews: PreviewProvider {
    static var previews: some View {
        RegisterPageDesign(viewModel: CryptoViewModel())
    }
}
