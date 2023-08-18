//
//  ProfilePage.swift
//  CryptoApp
//
//  Created by Eyüphan Akkaya on 8.08.2023.
//

import SwiftUI
import Firebase

struct ProfilePage: View {
    @ObservedObject var viewModel: CryptoViewModel
    @State var ref: DatabaseReference?
    @State var user: Users?
    @State var state = false
    var body: some View {
        NavigationView {
            VStack(spacing: 20){
                ZStack {
                    Circle()
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    Image(systemName: "person")
                        .font(.system(size: 50))
                    
                    
                }.frame(width: 80,height: 80)
                ForEach(viewModel.usersList,id: \.hashValue) { list in
                    Text("\(list.name)  \(list.surname)")
                        .frame(width: 345,height: 30)
                        .font(.system(size: 24))
                        .bold()
                    ZStack {
                        VStack(alignment: .leading) {
                            Text("Total Portfolio")
                                .frame(width: 115,height: 20)
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                            Text("$\(viewModel.totalWallet.asNumberString())")
                                .frame(width: 160,height: 40)
                                .font(.system(size: 32))
                                .foregroundColor(.white)
                                .bold()
                        }
                        .padding(.leading,-150)
                        
                        
                    }
                    .frame(width: 345,height: 112)
                    .cornerRadius(12)
                    .background(Color("iconColors"))
                    .cornerRadius(20)
                    .padding(.top,20)
                    
                    VStack {
                        //ticaret ücreti Trade Fee
                        Text("Mail")
                            .foregroundColor(.gray)
                            .offset(x:-155,y:-5)
                        
                        Text(list.email)
                            .offset(x: -120)
                            .padding(.leading,10)
                        
                        Rectangle()
                            .frame(width: 370,height: 1)
                            .foregroundColor(.gray)
                            .offset(y:-10)
                    }
                    .padding(.top,10)
                    VStack {
                        Text("Password")
                            .foregroundColor(.gray)
                            .offset(x:-135,y:-5)
                        
                        Text(list.password)
                            .offset(x: -145)
                            .padding(.leading,10)
                        
                        Rectangle()
                            .frame(width: 370,height: 1)
                            .foregroundColor(.gray)
                            .offset(y:-10)
                    }
                    .padding(.top,10)
                }
                
                
                Button {
                    viewModel.signOut()
                } label: {
                    Text("Log Out")
                        .foregroundColor(.white)
                }
                .frame(width: 345,height: 38)
                .cornerRadius(8)
                .background(Color("iconColors"))
                .cornerRadius(4)
                .padding()
                
            }
            .frame(height: 650)
            .background(Color("background"))
            .cornerRadius(10)

            
        }.onChange(of: viewModel.signOutState, perform: { newValue in
            if newValue {
                NavigationLink(destination: LoginPageDesign(viewModel: viewModel).navigationBarBackButtonHidden(true),isActive: $viewModel.signOutState) {
                    EmptyView()
                }
            }
        })
        .onAppear{
            print(viewModel.signOutState)
            if !state {
                viewModel.fetchData()
                state = true
            }

        }
        
        
    }
   
    

}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage(viewModel: CryptoViewModel())
    }
}
