//
//  SignupView.swift
//  IosFirebaseLogin
//
//  Created by admin on 15/03/24.
//

import SwiftUI

struct SignupView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var passwordConfirm = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Image("firebaseLogo")
                .resizable()
                .scaledToFit()
                .imageScale(.small)
            
            VStack(spacing: 24) {
                InputView(text: $email,
                          title: "Email Address",
                          placeholder: "name@example.com")
                .textInputAutocapitalization(TextInputAutocapitalization(.none))
                
                InputView(text: $password,
                          title: "Password",
                          placeholder: "******",
                          isSecureField: true)
                .textInputAutocapitalization(TextInputAutocapitalization(.none))
                
                InputView(text: $passwordConfirm,
                          title: "Confirm Password",
                          placeholder: "******",
                          isSecureField: true)
                .textInputAutocapitalization(TextInputAutocapitalization(.none))
            }
            .padding()
            
            Button {
                Task {
                    try await viewModel.createUser(withEmail: email, password: password)
                }
            } label: {
                HStack {
                    Text("SIGN UP")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            }
            .background(.blue)
            .cornerRadius(10)
            .padding()
            
            Button {
                
            } label: {
                HStack {
                    Text("GOOGLE SIGNIN")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            }
            .background(.blue)
            .cornerRadius(10)
            .padding()
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                HStack(spacing: 5) {
                    Text("Already have an account?")
                    Text("Login")
                        .fontWeight(.bold)
                }
                .font(.body)
            }
        }
    }
}

#Preview {
    SignupView()
}
