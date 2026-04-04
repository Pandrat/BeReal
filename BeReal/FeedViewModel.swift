//
//  FeedViewModel.swift
//  BeReal
//
//  Created by Sean Thelwell on 4/4/26.
//

import Foundation
import ParseSwift
import SwiftUI
import Combine

class FeedViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var errorMessage = ""
    @Published var showAlert = false
    
    func fetchPosts() {
        isLoading = true
        
        let query = Post.query()
            .include("user")
            .order([.descending("createdAt")])
            .limit(20)
        
        query.find { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let posts):
                    self?.posts = posts
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showAlert = true
                }
            }
        }
    }
    
    func createPost(imageFile: ParseFile, caption: String) {
        guard let currentUser = User.current else {
            errorMessage = "No user logged in"
            showAlert = true
            return
        }
        
        var post = Post()
        post.imageFile = imageFile
        post.caption = caption
        post.user = currentUser
        
        post.save { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.fetchPosts()
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showAlert = true
                }
            }
        }
    }
}
