//
//  MainTabView.swift
//  BeReal
//
//  Created by Sean Thelwell on 4/4/26.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        TabView {
            FeedView()
                .tabItem {
                    Label("Feed", systemImage: "house.fill")
                }
            
            CreatePostView()
                .tabItem {
                    Label("Post", systemImage: "camera.fill")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
    }
}
