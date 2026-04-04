//
//  CreatPostView.swift
//  BeReal
//
//  Created by Brianna Thelwell on 4/4/26.
//

import SwiftUI
import PhotosUI
import ParseSwift

struct CreatePostView: View {
    
    @StateObject private var feedViewModel = FeedViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    @State private var caption = ""
    @State private var isUploading = false
    
    var body: some View {
        
        NavigationView {
            
            VStack(spacing: 20) {
                
                if let selectedImage = selectedImage {
                    
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 400)
                        .cornerRadius(10)
                    
                } else {
                    
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(maxHeight: 400)
                        .overlay(
                            VStack {
                                
                                Image(systemName: "photo.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.gray)
                                Text("Tap to select a photo")
                                    .foregroundColor(.gray)
                                
                            }
                            
                        )
                    
                        .cornerRadius(10)
                        .onTapGesture {
                            // Trigger photo picker
                            //it was NOT working at first ong
                            
                        }
                    
                }
                
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    Label("Select Photo", systemImage: "photo.on.rectangle")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.mint)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    
                }
                
                TextField("Add a caption...", text: $caption)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button(action: uploadPost) {
                    
                    if isUploading {
                        
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        
                    } else {
                        
                        Text("Post")
                            .frame(maxWidth: .infinity)
                        
                    }
                    
                }
                
                .frame(maxWidth: .infinity)
                .padding()
                .background(selectedImage != nil ? Color.green : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
                .disabled(selectedImage == nil || isUploading)
                
                Spacer()
                
            }
            
            .padding()
            .navigationTitle("New Post")
            .onChange(of: selectedItem) { _, newItem in
                Task {
                    
                    if let data = try? await newItem?.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        await MainActor.run {
                            selectedImage = image
                            
                        }
                        
                    }
                    
                }
                
            }
            
            .alert("Error", isPresented: $feedViewModel.showAlert) {
                
                Button("OK", role: .cancel) { }
                
            } message: {
                
                Text(feedViewModel.errorMessage)
                
            }
            
        }
        
    }
    
    private func uploadPost() {
        
        guard let selectedImage = selectedImage,
              let imageData = selectedImage.jpegData(compressionQuality: 0.5) else { return }
        
        isUploading = true
        
        let imageFile = ParseFile(name: "photo.jpg", data: imageData)
        
        //Added explicit type annotation for the result parameter
        //BECAUSE IT KEPT ERRORING
        //had to get so much help for this bit
        imageFile.save { (result: Result<ParseFile, ParseError>) in
            switch result {
                
            case .success(let savedFile):
                feedViewModel.createPost(imageFile: savedFile, caption: caption)
                DispatchQueue.main.async {
                    
                    isUploading = false
                    dismiss()
                    
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    
                    isUploading = false
                    feedViewModel.errorMessage = error.localizedDescription
                    feedViewModel.showAlert = true
                    
                }
                
            }
            
        }
        
    }
    
}
//All this becasuse im bad at storyboards mind you
