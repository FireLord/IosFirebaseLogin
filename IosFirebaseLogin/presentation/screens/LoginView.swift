//
//  ContentView.swift
//  IosFirebaseLogin
//
//  Created by admin on 15/03/24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationStack {
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
                }
                .padding()
                
                NavigationLink {
                    ForgoutPasswordView()
                } label: {
                    Text("Forgot Password?")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundColor(.blue)
                        .padding(.horizontal)
                }
                
                Button {
                    Task {
                        try await viewModel.signIn(withEmail: email, password: password)
                    }
                } label: {
                    HStack {
                        Text("LOGIN IN")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(.blue)
                .cornerRadius(10)
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                .padding()
                
                Button {
                    Task {
                        try await viewModel.signInGoogle()
                    }
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
                
                NavigationLink {
                    SignupView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack(spacing: 5) {
                        Text("Dont have an account?")
                        Text("Sign up")
                            .fontWeight(.bold)
                    }
                    .font(.body)
                }
            }
        }
    }
}

#Preview {
    LoginView()
}

extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}
