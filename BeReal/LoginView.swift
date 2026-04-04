//
//  LoginView.swift
//  BeReal
//
//  Created by Sean Thelwell on 4/4/26.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var username = ""
    @State private var password = ""
    @State private var isSignUp = false
    @State private var email = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Be  Real.")
                .frame(width: 100, height: 100)
                .cornerRadius(20)
                .font(Font.largeTitle.monospacedDigit())
                .foregroundColor(.teal)
                .padding(.bottom, 20)
                .shadow(color: .mint, radius: 5)
            
            Text(isSignUp ? "Create Account" : "Welcome Back!")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            VStack(spacing: 15) {
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                
                if isSignUp {
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                }
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.horizontal)
            
            Button(action: {
                if isSignUp {
                    authViewModel.signUp(username: username, password: password, email: email)
                } else {
                    authViewModel.login(username: username, password: password)
                }
            }) {
                Text(isSignUp ? "Sign Up" : "Log In")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.mint)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            Button(action: {
                isSignUp.toggle()
                username = ""
                password = ""
                email = ""
            }) {
                Text(isSignUp ? "Already have an account? Log In" : "Don't have an account? Sign Up")
                    .foregroundColor(.mint)
            }
        }
        .padding()
        .alert("Error", isPresented: $authViewModel.showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(authViewModel.errorMessage)
        }
    }
}
