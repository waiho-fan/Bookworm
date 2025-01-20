//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Gary on 31/12/2024.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
