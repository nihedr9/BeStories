

import SwiftUI
import SwiftData
import Model

@MainActor
public protocol DatabaseService {
  var mainContext: ModelContext { get }
  
  func countStories() -> Int
  func fetchStories(descriptor: FetchDescriptor<Story>) throws -> [Story]
  func save(models: [UserModel]) throws
  func toggleIsLiked(story: Story) throws
  func updateHasBeenSeen(story: Story, hasBeenSeen: Bool) throws
}

@MainActor
public struct Database: DatabaseService {
  
  public let mainContext: ModelContext
  
  public init(container: ModelContainer) {
    self.mainContext = container.mainContext
  }
  
  public func save(models: [UserModel]) throws {
    models.map { User(user: $0)}
      .map { Story(id: UUID().uuidString, user: $0) }
      .forEach { mainContext.insert($0) }
    
    try mainContext.save()
  }
  
  public func countStories() -> Int {
    do {
      let descriptor = FetchDescriptor<Story>()
      return try mainContext.fetchCount(descriptor)
    } catch {
      return 0
    }
  }
  
  public func fetchStories(descriptor: FetchDescriptor<Story>) throws -> [Story] {
    return try mainContext.fetch(descriptor)
  }
  
  public func toggleIsLiked(story: Story) throws {
    story.isLiked = !story.isLiked
    try mainContext.save()
  }
  
  public func updateHasBeenSeen(story: Story, hasBeenSeen: Bool) throws {
    story.hasBeenSeen = hasBeenSeen
    try mainContext.save()
  }
}

public extension ModelContainer {
  static var inMemory: ModelContainer {
    let schema = Schema([
      Story.self,
      User.self
    ])
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
    do {
      return try ModelContainer(for: schema, configurations: [modelConfiguration])
    } catch {
      fatalError("Could not create ModelContainer: \(error)")
    }
  }
}
