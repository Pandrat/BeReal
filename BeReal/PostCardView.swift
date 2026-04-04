//
//  PostCardView.swift
//  BeReal
//
//  Created by Sean Thelwell on 4/4/26.
//

import ParseSwift
import SwiftUI

struct PostCardView: View {
    let post: Post
    @State private var image: UIImage?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 40, height: 40)
                    .overlay(
                        Image(systemName: "person.fill")
                            .foregroundColor(.gray)
                    )
                
                VStack(alignment: .leading) {
                    Text(post.user?.username ?? "Unknown User")
                        .font(.headline)
                    Text(post.createdAt?.formatted() ?? "")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
            
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .aspectRatio(1, contentMode: .fit)
                    .overlay(ProgressView())
                    .onAppear {
                        loadImage()
                    }
            }
            
            if let caption = post.caption, !caption.isEmpty {
                Text(caption)
                    .font(.body)
                    .padding(.top, 5)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
    }
    
    private func loadImage() {
        post.imageFile?.fetch { result in
            switch result {
            case .success(let file):
                if let url = file.url,
                   let data = try? Data(contentsOf: url),
                   let loadedImage = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = loadedImage
                    }
                }
            case .failure(let error):
                print("Error loading image: \(error)")
            }
        }
    }
}
