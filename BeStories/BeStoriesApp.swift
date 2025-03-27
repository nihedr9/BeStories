//
//  BeStoriesApp.swift
//  BeStories
//
//  Created by Nihed Majdoub on 27/03/2025.
//

import SwiftUI
import SwiftData
import Model
import Network
import Database

@main
struct BeStoriesApp: App {
  
  var sharedModelContainer: ModelContainer = {
    let schema = Schema([
      Story.self,
      User.self
    ])
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
    do {
      return try ModelContainer(for: schema, configurations: [modelConfiguration])
    } catch {
      fatalError("Could not create ModelContainer: \(error)")
    }
  }()
  
  var body: some Scene {
    WindowGroup {
      StoriesView(viewModel: StoriesViewModel(dataService: DataFetcher.shared, database: Database(container: sharedModelContainer)))
        .modelContainer(sharedModelContainer)
        .colorScheme(.dark)
    }
  }
}
