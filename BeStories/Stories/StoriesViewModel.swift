//
//  StoriesViewModel.swift
//  BeStories
//
//  Created by Nihed Majdoub on 27/03/2025.
//

import SwiftUI
import Network
import Database
import Model
import SwiftData

enum ViewState<T: Identifiable>: Identifiable, Equatable {
  
  static func == (lhs: ViewState<T>, rhs: ViewState<T>) -> Bool {
    lhs.id == rhs.id
  }
  
  case idle
  case loading
  case failed(SroriesError)
  case loaded([T])
  
  var id: String {
    switch self {
    case .loaded:
      "loaded"
    case .idle:
      "idle"
    case .loading:
      "loading"
    case .failed:
      "error"
    }
  }
}

enum SroriesError: Error {
  case noData
  
  var title: String {
    "No data"
  }
}

@MainActor
@Observable
final class StoriesViewModel: StoriesViewModelProtocol {
  
  init(dataService: any DataService, database: any DatabaseService) {
    self.dataService = dataService
    self.database = database
  }
  
  private let database: DatabaseService
  private let dataService: DataService
  
  private let pageSize = 5
  private var currentLimit = 0
  
  private(set) var state = ViewState<Story>.idle
  
  var hasMoreStories: Bool {
    currentLimit < storiesCount
  }
  
  var storiesCount: Int {
    database.countStories()
  }
  
  func fetchStories() async {
    if storiesCount == 0 {
      state = .loading
      try? await Task.sleep(nanoseconds: 1_500_000_000)
    }
    do {
      let users = try dataService.fetchUsers()
      try database.save(models: users)
      currentLimit += pageSize
      let stories = try await getStories(limit: currentLimit)
      state = .loaded(stories)
    } catch {
      state = .failed(SroriesError.noData)
    }
  }
  
  func loadMoreStories() async {
    guard hasMoreStories else {
      return
    }
    do {
      try await Task.sleep(nanoseconds: 1_000_000_000)
      currentLimit += pageSize
      let stories = try await getStories(limit: currentLimit)
      state = .loaded(stories)
    } catch {
      // TODO: implement an error alert toast
    }
  }
  
  internal func getStories(limit: Int) async throws -> [Story] {
    var descriptor = FetchDescriptor<Story>()
    descriptor.fetchLimit = currentLimit
    descriptor.sortBy = [.init(\Story.creationDate, order: .forward)]
    return try database.fetchStories(descriptor: descriptor)
  }
  
  func updateHasBeenSeen(story: Story, hasBeenSeen: Bool) {
    do {
      try database.updateHasBeenSeen(story: story, hasBeenSeen: hasBeenSeen)
    } catch {
      // TODO: implement an error alert toast
    }
  }
}

@MainActor
protocol StoriesViewModelProtocol {
  var state: ViewState<Story> { get }
  func loadMoreStories() async
  var hasMoreStories: Bool { get }
  
  func fetchStories() async
  func getStories(limit: Int) async throws -> [Story]
  func updateHasBeenSeen(story: Story, hasBeenSeen: Bool)
}
