//
//  ContentView.swift
//  BeReal
//
//  Created by Brianna Thelwell on 4/4/26.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some View {
        
        if authViewModel.isAuthenticated {
            
            MainTabView()
                .environmentObject(authViewModel)
            
        } else {
            
            LoginView()
                .environmentObject(authViewModel)
            
        }
        
    }
    
}


