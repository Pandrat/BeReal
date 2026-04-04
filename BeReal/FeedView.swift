//
//  FeedView.swift
//  BeReal
//
//  Created by Sean Thelwell on 4/4/26.
//

import SwiftUI

struct FeedView: View {
    @StateObject private var feedViewModel = FeedViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                if feedViewModel.isLoading && feedViewModel.posts.isEmpty {
                    ProgressView()
                        .padding()
                } else {
                    LazyVStack(spacing: 20) {
                        ForEach(feedViewModel.posts, id: \.objectId) { post in
                            PostCardView(post: post)
                        }
                    }
                    .padding()
                }
            }
            .refreshable {
                feedViewModel.fetchPosts()
            }
            .navigationTitle("BeReal Feed")
            .onAppear {
                feedViewModel.fetchPosts()
            }
            .alert("Error", isPresented: $feedViewModel.showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(feedViewModel.errorMessage)
            }
        }
    }
}
