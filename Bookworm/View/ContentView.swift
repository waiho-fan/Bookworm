//
//  ContentView.swift
//  Bookworm
//
//  Created by iOS Dev Ninja on 31/12/2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [
        SortDescriptor(\Book.title),
        SortDescriptor(\Book.author)
    ]) var books: [Book]
    
    @State private var showingAddScreen = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        BookRow(book: book)
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
                .onDelete(perform: deleteBooks)
            }
            .listStyle(.plain)
            .navigationTitle("Bookworm")
            .navigationDestination(for: Book.self) {
                DetailView(book: $0)
            }
            
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Book", systemImage: "plus") {
                        showingAddScreen.toggle()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
            }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            modelContext.delete(book)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Book.self, inMemory: true)
}

struct BookRow: View {
    let book: Book
    
    var body: some View {
        VStack {
            Image(book.genre)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 10))
            HStack(alignment:.top, spacing: 15) {
                VStack(alignment: .leading) {
                    Text(book.title)
                        .font(.system(.title2, design: .rounded))
                    
                    Text(book.author)
                        .font(.system(.body, design: .rounded))
                    
                    Text(book.formattedDate)
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundStyle(.gray)
                }
                Spacer()

                EmojiRatingView(rating: book.rating)
                    .font(.largeTitle)
            }
            .foregroundStyle(book.rating == 1 ? .red : .primary)

        }
        
    }
}
