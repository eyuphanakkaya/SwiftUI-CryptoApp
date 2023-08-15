//
//  RegisterPageDesign.swift
//  CryptoApp
//
//  Created by Eyüphan Akkaya on 10.08.2023.
//

import SwiftUI
import Firebase

struct RegisterPageDesign: View {
    @Environment(\.presentationMode) var presentationMode
    @State var registerMail = ""
    @State var registerName = ""
    @State var registerSurname = ""
    @State var registerPassword = ""
    @State var registerRepaetPassword = ""
    @State private var isEmailValid : Bool   = true
    @State private var isSecured: Bool = true
    @State var ref: DatabaseReference?
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
                saveUser(name: registerName, surname: registerSurname, password: registerPassword, repeatPassword: registerRepaetPassword, mail: registerMail)
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
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Already have an account? Enter here")
                    .foregroundColor(Color("iconColors"))
            }
            .frame(width: 345,height: 16)
            .font(.system(size: 12))
        }.onAppear{
            ref = Database.database().reference()
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
                print("Kayıt Başarıyla Oluşturuldu.")
            }
        }
    }
}

struct RegisterPageDesign_Previews: PreviewProvider {
    static var previews: some View {
        RegisterPageDesign()
    }
}
