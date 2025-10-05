//
//  BookDescriptionViewModel.swift
//  Leaf
//
//  Created by Mohamed Atallah on 26/09/2025.
//


import SwiftUI

struct BookDescriptionView: View {
    let book: Book
    @StateObject private var viewModel = BookDescriptionViewModel()
    @StateObject private var coverViewModel = CoverViewModel()
    @State private var showAlert: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 28) {
                
                // MARK: - Hero Cover + Title
                VStack(spacing: 16) {
                    Group {
                        if coverViewModel.isLoading {
                            ProgressView()
                                .frame(width: 140, height: 200)
                        } else if let image = coverViewModel.image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 160, height: 230)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .shadow(radius: 8)
                        } else {
                            Image(systemName: "book.closed.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 140, height: 200)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    VStack(spacing: 6) {
                        Text(book.title ?? "Unknown Title")
                            .font(.title2.bold())
                            .multilineTextAlignment(.center)
                        
                        Text(book.authors?.first?.name ?? "Unknown Author")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.top)
                
                Divider()
                
                // MARK: - Info Section
                HStack(spacing: 24) {
                    if let editionCount = book.editionCount {
                        infoCard(title: "Editions", value: "\(editionCount)")
                    }
                    if let year = book.firstPublishYear {
                        infoCard(title: "First Published", value: "\(year)")
                    }
                }
                .frame(maxWidth: .infinity)
                
                Divider()
                
                // MARK: - Actions
                VStack(spacing: 14) {
                    LazyVGrid(columns: [
                        GridItem(.flexible(minimum: 50, maximum: .infinity)),
                        GridItem(.flexible(minimum: 50, maximum: .infinity))
                    ],
                              alignment: .leading,
                              spacing: 10
                    ) {
                        ForEach(UserColletion.allCases, id: \.self) { collection in
                            AddToCollectionButton(
                                book: book,
                                collection: collection,
                                viewModel: viewModel,
                                showAlert: $showAlert
                            )
                        }
                    }
                }
                
                Spacer(minLength: 60)
            }
            .padding(.horizontal)
        }
        .onAppear {
            Task { await coverViewModel.getCover(for: book) }
        }
        .alert(viewModel.alertMessage, isPresented: $showAlert) {
            Button("OK") {}
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - Helper View
    @ViewBuilder
    private func infoCard(title: String, value: String) -> some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.headline)
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct AddToCollectionButton: View {
    let book: Book
    let collection: UserColletion
    
    @ObservedObject var viewModel: BookDescriptionViewModel
    @Binding var showAlert: Bool
    
    var body: some View {
        Button {
            Task {
                await viewModel.addToUserCollection(book: book, collection: collection)
                showAlert.toggle()
            }
        } label: {
                Text(collection.displayName)
                    .fontWeight(.semibold)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(.systemGray6))
            .foregroundStyle(.green)
        }
        .buttonStyle(.plain)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    NavigationView {
        BookDescriptionView(book: .sambleData)
    }
}
