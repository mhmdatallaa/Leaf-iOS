import SwiftUI

struct BookDescriptionView: View {
    let book: Book
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // Cover
                if let coverID = book.coverID {
                    AsyncImage(url: URL(string: "https://covers.openlibrary.org/b/id/\(coverID)-L.jpg")) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 180, height: 260)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 180, height: 260)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .shadow(radius: 6)
                        case .failure:
                            Image(systemName: "book.closed")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 160)
                                .foregroundColor(.gray)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 30)
                }
                
                // Title & Author
                VStack(alignment: .leading, spacing: 6) {
                    Text(book.title ?? "Unknown Title")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                    
                    Text("by \(book.authors?.first?.name ?? "Unknown Author")")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                
                Divider()
                    .padding(.horizontal)
                
                // Extra Info
                VStack(alignment: .leading, spacing: 8) {
                    if let editionCount = book.editionCount {
                        HStack {
                            Text("Editions:")
                                .fontWeight(.semibold)
                            Text("\(editionCount)")
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    if let year = book.firstPublishYear {
                        HStack {
                            Text("First Published:")
                                .fontWeight(.semibold)
                            Text("\(year)")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding(.horizontal)
                
                Spacer(minLength: 40)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    NavigationView {
        BookDescriptionView(book: .sambleData)
    }
}
