//
//  HomeView.swift
//  IosFirebaseLogin
//
//  Created by admin on 15/03/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        List {
            Section {
                HStack {
                    Text("MJ")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 72, height: 72)
                        .background(.gray)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Max Joshi")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(.top, 4)
                        
                        Text(viewModel.currentUser?.email ?? "")
                            .font(.footnote)
                            .accentColor(.gray)
                    }
                }
            }
            
            Section("General") {
                HStack {
                    SettingRowView(imageName: "gear",
                                   title: "Version",
                                   tintColor: .gray)
                    
                    Spacer()
                    
                    Text("1.0.0")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            
            Section("Account") {
                Button {
                    
                } label: {
                    SettingRowView(imageName: "arrow.left.circle.fill",
                                   title: "Sign out",
                                   tintColor: .red)
                }
                
                Button {
                    
                } label: {
                    SettingRowView(imageName: "xmark.circle.fill",
                                   title: "Delete Account",
                                   tintColor: .red)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
