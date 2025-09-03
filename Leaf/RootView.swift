//
//  ContentView.swift
//  Leaf
//
//  Created by Mohamed Atallah on 02/09/2025.
//

import SwiftUI

struct RootView: View {
//    @Binding var name: String
    @State private var showSignInView: Bool = false

    var body: some View {

        ZStack {
            NavigationStack {
                SettingView(showLoginView: $showSignInView, name: "")
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
