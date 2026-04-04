//
//  LaunchScreenView.swift
//  BeReal
//
//  Created by Sean Thelwell on 4/4/26.
//

import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        VStack {
            Image("app_icon")
                .resizable()
                .frame(width: 100, height: 100)
                .cornerRadius(20)
            Text("BeReal Clone")
                .font(.title)
                .fontWeight(.bold)
            Text("Share your real moments")
                .foregroundColor(.gray)
        }
    }
}
