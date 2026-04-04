//
//  BeRealApp.swift
//  BeReal
//
//  Created by Brianna Thelwell on 4/4/26.
//

import SwiftUI
import ParseSwift

@main
struct BeRealApp: App {
    
    init() {
        
        // Initialize Parse
        ParseSwift.initialize(
            applicationId: "qWxnmPldRjItu2Z60vUu8jwsmNMiXrmZQguccaSE",
            clientKey: "onmpzKPhx4QStKTMKMtOjHAhRfmUKomf5ZnKkTfj",
            serverURL: URL(string: "https://parseapi.back4app.com")!
        )
        
    }
    
    var body: some Scene {
        
        WindowGroup {
            
            ContentView()
            
        }
        
    }
    
}
