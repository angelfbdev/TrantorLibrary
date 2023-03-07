//
//  LoginView.swift
//  TrantorLibrary
//
//  Created by Angel Fernandez Barrios on 15/2/23.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var vm: GeneralViewModel
    
    @State var email = ""
    @State var newUser = false
    
    var body: some View {
        ZStack {
            VStack {
                VStack(alignment: .leading) {
                    Text("Usuario")
                        .bold()
                        .padding(.horizontal)
                        .padding(.top)
                    
                    HStack {
                        Image(systemName: "envelope")
                            .resizable()
                            .frame(width: 25, height: 18)
                            .bold()
                        TextField("Enter email address...", text: $email)
                            .padding(.vertical, 5)
                            .padding(.leading, 7)
                            .textInputAutocapitalization(.never)
                            .background(Color.white.opacity(0.6))
                            .keyboardType(.emailAddress)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .padding(.horizontal)
                }
                .foregroundColor(Color("Primary"))
                
                VStack {
                    Button {
                        if vm.validateEmail(email: email.lowercased()) {
                            Task {
                                if await vm.getUser(email:email) {
                                    if vm.userData.role == "usuario" {
                                        vm.screen = .userHome
                                    } else {
                                        vm.screen = .adminHome
                                    }
                                }
                            }
                        }
                    } label: {
                        Text("Log on")
                            .bold()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.white)
                    
                    Button {
                        newUser.toggle()
                    } label: {
                        Text("No account yet?")
                    }
                }
                .padding()
                .foregroundColor(Color("Primary"))
            }
            .frame(height: 400)
            .background(Color("Primary").opacity(0.3))
            .cornerRadius(20)
            .padding()
            .alert("Invalid User", isPresented: $vm.showAlertLogin) {
                Button("OK", role: .cancel) {}
                    .buttonStyle(.bordered)
            } message: {
                Text(vm.errorMsg)
            }
            .sheet(isPresented: $newUser) {
                NewUserView(user: true, locked: false, newUser: $newUser)
            }
            
            Image("trantor_wo_bg")
                .resizable()
                .frame(width: 200, height: 200)
                .padding(.bottom, 410)
        }
        .padding(.top, 50)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(GeneralViewModel())
    }
}
