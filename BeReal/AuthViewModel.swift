//
//  AuthViewModel.swift
//  BeReal
//
//  Created by Brianna Thelwell on 4/4/26.
//

import Foundation
import ParseSwift
import SwiftUI
import Combine

class AuthViewModel: ObservableObject {
    
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    @Published var errorMessage = ""
    @Published var showAlert = false
    
    init() {
        
        checkAuthentication()
        
    }
    
    func checkAuthentication() {
        
        if let currentUser = User.current {
            
            self.currentUser = currentUser
            self.isAuthenticated = true
            
        }
        
    }
    
    func signUp(username: String, password: String, email: String) {
        
        var user = User()
        user.username = username
        user.password = password
        user.email = email
        
        user.signup { [weak self] result in
            DispatchQueue.main.async {
                
                switch result {
                    
                case .success(let user):
                    self?.currentUser = user
                    self?.isAuthenticated = true
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showAlert = true
                    
                }
                
            }
            
        }
        
    }
    
    func login(username: String, password: String) {
        
        User.login(username: username, password: password) {
            [weak self] result in
            DispatchQueue.main.async {
                
                switch result {
                    
                case .success(let user):
                    self?.currentUser = user
                    self?.isAuthenticated = true
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showAlert = true
                    
                }
                
            }
            
        }
        
    }
    
    func logout() {
        
        User.logout { [weak self] result in
            DispatchQueue.main.async {
                
                switch result {
                    
                case .success:
                    self?.currentUser = nil
                    self?.isAuthenticated = false
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showAlert = true
                    
                }
                
            }
            
        }
        
    }
    
}


