//
//  Untitled.swift
//  BeReal
//
//  Created by Sean Thelwell on 4/4/26.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 100, height: 100)
                    .overlay(
                        Image(systemName: "person.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                    )
                
                Text(authViewModel.currentUser?.username ?? "User")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(authViewModel.currentUser?.email ?? "")
                    .foregroundColor(.gray)
                
                Button(action: {
                    authViewModel.logout()
                }) {
                    Text("Log Out")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.teal)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Profile")
        }
    }
}
