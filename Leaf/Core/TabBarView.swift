//
//  TabBarView.swift
//  Leaf
//
//  Created by Mohamed Atallah on 25/09/2025.
//

import SwiftUI

struct TabBarView: View {
    @Binding var showSignInView: Bool
    var body: some View {
        NavigationStack {
            TabView {
                ExploreView()
                    .tabItem {
                        Label("Explore", systemImage: "books.vertical")
                    }
                FavoriteView()
                    .tabItem {
                        Label("Favorite", systemImage: "star.fill")
                    }
                ProfileView(showSignInView: $showSignInView)
                    .tabItem {
                        Label("Profile", systemImage: "person")
                    }
                
            }
        }
    }
}

#Preview {
    TabBarView(showSignInView: .constant(false))
}
