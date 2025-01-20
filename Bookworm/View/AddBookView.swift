//
//  AddBookView.swift
//  Bookworm
//
//  Created by Gary on 31/12/2024.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var isAddValid: Bool {
        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            author.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            genre.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            review.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            rating == 0 {
            return false
        }
        return true
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)

                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section("Write a review") {
//                    TextEditor(text: $review)
                    TextField("Review", text: $review, axis: .vertical)
                    RatingView(rating: $rating)
                }

                Section {
                    Button("Save") {
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating, date: .now)
                        modelContext.insert(newBook)
                        dismiss()
                    }
                    .frame(maxWidth: .infinity)
                    .font(.title2)
                }
                .disabled(isAddValid == false)
            }
            .navigationTitle("Add Book")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AddBookView()
        .preferredColorScheme(.dark)
}
