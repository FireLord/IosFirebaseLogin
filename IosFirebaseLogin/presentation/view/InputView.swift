//
//  InputView.swift
//  IosFirebaseLogin
//
//  Created by admin on 15/03/24.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .foregroundColor(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
            
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .font(.footnote)
            } else {
                TextField(placeholder, text: $text)
                    .font(.footnote)
            }
            
            Divider()
        }
    }
}

#Preview {
    InputView(text: .constant(""), title: "Email Address", placeholder: "xyz@gmail.com")
}
