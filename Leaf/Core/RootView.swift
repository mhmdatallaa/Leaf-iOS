//
//  ContentView.swift
//  Leaf
//
//  Created by Mohamed Atallah on 02/09/2025.
//

import SwiftUI

struct RootView: View {
    @State private var showSignInView: Bool = false
    
    var body: some View {
        ZStack {
            if !showSignInView {
                TabBarView(showSignInView: $showSignInView)
            }
        }
        .onAppear {
            Task {
                let authUser = try? await AuthService.shared.getAuthenticatedUser()
                self.showSignInView = authUser == nil
            }
        }
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationStack {
                SignInView(showSignInView: $showSignInView)
            }
        }
    }
}

#Preview {
    RootView()
}
