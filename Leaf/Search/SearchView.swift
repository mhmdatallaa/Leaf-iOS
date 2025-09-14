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
                    .padding(.top, 180)
                
                subjectSection
                    .frame(height: 100)
                
                Text("Popular")
                    .padding(.trailing, 210)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(),
                        GridItem(),
                        //                            GridItem(),
                    ], spacing: 50) {
                        ForEach(viewModel.books) { book in
                            BookCellView(book: book)
                        }
                    }
                }
                .scrollIndicators(.hidden)
                
                
                
            }
            .padding(.horizontal)
            .navigationTitle("Leaf")
            .ignoresSafeArea()
        }
        .onAppear {
            Task { await viewModel.getBooksBySubject(selectedSubject) }
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
                        Task {
                            await viewModel.getBooksBySubject(selectedSubject)
                        }
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
