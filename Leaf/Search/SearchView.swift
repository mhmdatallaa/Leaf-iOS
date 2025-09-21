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
            VStack(alignment: .leading) {
                searchField
                    .padding(.top, 180)
                
                subjectSection
                    .frame(height: 100)
                
                booksSection
            }
            .padding(.horizontal)
            .navigationTitle("Leaf")
            .ignoresSafeArea()
        }
        .onAppear {
            Task { await viewModel.getBooksBySubject("fantasy") }
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
            TextField("Search books by Title or Author", text: $viewModel.searchText)
                .onChange(of: viewModel.searchText) { oldValue, newValue in
                    Task { await viewModel.searchBook(newValue) }
                }
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color(.systemGray4), lineWidth: 1)
        }
    }
    
    private var subjectSection: some View {
        LazyHGrid(rows: [
            GridItem(.fixed(20)),
            GridItem(.fixed(20)),
            //                        GridItem(),
        ], alignment: .top, spacing: 15) {
            ForEach(viewModel.subjects, id: \.self) { subject in
                Text(subject)
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 5)
                    .foregroundStyle(selectedSubject == subject && viewModel.searchText.isEmpty ? .white : .green)
                    .onTapGesture {
                        viewModel.searchText = ""
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
                            .foregroundStyle(selectedSubject == subject && viewModel.searchText.isEmpty ? Color.green : Color.clear)
                    }
                
            }
        }
    }
    
    private var booksSection: some View {
        VStack(alignment: .leading) {
            Text(viewModel.searchText == "" ? "Books" : "Search for ``\(viewModel.searchText)``")
                .font(viewModel.searchText.isEmpty ? .largeTitle : .callout)
                .fontWeight(.bold)
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(),
                    GridItem(),
                ], spacing: 50) {
                    ForEach(viewModel.books) { book in
                        BookCellView(book: book)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}
