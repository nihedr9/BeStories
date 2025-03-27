//
//  Story.swift
//  BeStories
//
//  Created by Nihed Majdoub on 27/03/2025.
//

import Foundation
import SwiftData

@Model
public class Story: Identifiable {
    
  public var id: String
  public var user: User
  public var isLiked = false
  public var hasBeenSeen = false
  public var creationDate = Date()
  
  public var mediaUrl: URL? {
    URL(string: "https://picsum.photos/1920/1080?random=\(id)")
  }
  
  public init(
    id: String,
    user: User,
    isLiked: Bool = false,
    hasBeenSeen: Bool = false
  ) {
   self.id = id
   self.user = user
   self.isLiked = isLiked
   self.hasBeenSeen = hasBeenSeen
 }
}

public extension Story {
  static var placeholders: [Story] {
    [
      Story(id: UUID().uuidString, user: User(id: "1", name: "John Doe", avatar: "https://picsum.photos/200"), isLiked: true),
      Story(id: UUID().uuidString, user: User(id: "2", name: "John Doe", avatar: "https://picsum.photos/200")),
      Story(id: UUID().uuidString, user: User(id: "3", name: "John Doe", avatar: "https://picsum.photos/200")),
      Story(id: UUID().uuidString, user: User(id: "1", name: "John Doe", avatar: "https://picsum.photos/200"), hasBeenSeen: true),
      Story(id: UUID().uuidString, user: User(id: "2", name: "John Doe", avatar: "https://picsum.photos/200")),
      Story(id: UUID().uuidString, user: User(id: "3", name: "John Doe", avatar: "https://picsum.photos/200"))
    ]
  }
}
