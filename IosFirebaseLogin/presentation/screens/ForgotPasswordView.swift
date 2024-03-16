//
//  ForgoutPasswordView.swift
//  Soundscape
//
//  Created by admin on 04/03/24.
//

import SwiftUI

struct ForgoutPasswordView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State var email = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            InputView(text: $email,
                      title: "Email Address",
                      placeholder: "name@example.com")
            .textInputAutocapitalization(TextInputAutocapitalization(.none))
            .padding()
            
            Button {
                Task {
                    try await viewModel.forgotPassword(withEmail: email)
                }
            } label: {
                HStack {
                    Text("SEND RESET EMAIL")
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
        }
        .navigationTitle("Forgot Password")
    }
}

#Preview {
    ForgoutPasswordView()
}
