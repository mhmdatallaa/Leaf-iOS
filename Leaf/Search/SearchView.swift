//
//  SearchView.swift
//  Leaf
//
//  Created by Mohamed Atallah on 12/09/2025.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @State private var selectedSubject = ""
    var body: some View {
        NavigationView {
                VStack {
                    searchField
//                        .background(Color.yellow)
//                        .frame(height: 100)
                        .padding(.top, 180)

                    subjectSection
//                        .background(Color.red)
                        .frame(height: 100)
                    
                    Text("Popular")
                        .padding(.trailing, 210)
//                        .foregroundStyle(.black)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    ScrollView {
                        LazyVGrid(columns: [
                            GridItem(),
                            GridItem(),
                            GridItem(),
                        ], spacing: 50) {
                            ForEach(0..<30) {_ in
                                BookCellView()
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                    
                    

            }
            .padding(.horizontal)
            .navigationTitle("Leaf")
//            .searchable(text: $viewModel.searchText, prompt: "Search books by name or author")
            .ignoresSafeArea()
//            .navigationBarTitleDisplayMode(.inline)
//            .foregroundStyle(.green)
        }
    }
}

#Preview {
    NavigationView {
        SearchView()
    }
}

extension SearchView {
    private var searchField: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search books by name or author", text: $viewModel.searchText)
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color(.systemGray4), lineWidth: 1)
        }
    }
    
    private var subjectSection: some View {
        LazyHGrid(rows: [
            GridItem(.fixed(30)),
            GridItem(.fixed(30)),
//                        GridItem(),
        ], alignment: .top, spacing: 15) {
            ForEach(viewModel.subjects, id: \.self) { subject in
                Text(subject)
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 5)
                    .foregroundStyle(.white)
                    .onTapGesture {
                        withAnimation {
                            selectedSubject = subject
                        }
                        Logger.shared.log("\(subject) tapped")
                    }
                    .background {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(selectedSubject == subject ? Color.red : Color.green)
                    }
                
            }
        }
        .padding(.top)
    }
}
