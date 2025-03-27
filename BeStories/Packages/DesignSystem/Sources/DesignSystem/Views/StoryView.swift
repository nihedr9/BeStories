//
//  StoryView.swift
//  BeStories
//
//  Created by Nihed Majdoub on 27/03/2025.
//

import SwiftUI
import Kingfisher
import Model

public struct StoryView: View {
  
  let item: Item
  
  public init(item: StoryView.Item) {
    self.item = item
  }
  
  public var body: some View {
    VStack(spacing: 8) {
      ZStack(alignment: .topTrailing) {
        
        KFImage(.init(string: item.avatar))
          .resizable()
          .fade(duration: 0.2)
          .placeholder { Color.gray }
          .scaledToFill()
          .frame(width: 80, height: 80)
          .overlay(
            Circle()
              .stroke(LinearGradient(colors: item.hasBeenSeen ? [.white] : [.red, .purple, .red, .orange, .yellow, .orange], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 3)
          )
          .clipShape(Circle())
        
        if item.isLiked {
          Image(systemName: "heart.fill")
            .font(.callout)
            .foregroundStyle(.red)
            .offset(x: 0, y: 4)
        }
      }
      
      Text(item.name)
        .font(.caption)
        .foregroundStyle(.white)
        .lineLimit(1)
    }
    .frame(width: 90)
  }
}

#Preview {
  StoryView(item: .mock)
}

public extension StoryView {
  struct Item {
    let avatar: String
    let name: String
    let hasBeenSeen: Bool
    let isLiked: Bool
    
    public init(avatar: String, name: String, hasBeenSeen: Bool, isLiked: Bool) {
      self.avatar = avatar
      self.name = name
      self.hasBeenSeen = hasBeenSeen
      self.isLiked = isLiked
    }
    
    public init(from story: Story) {
      self.init(
        avatar: story.user.avatar,
        name: story.user.name,
        hasBeenSeen: story.hasBeenSeen,
        isLiked: story.isLiked
      )
    }
  }
}

extension StoryView.Item {
  static var mock: Self {
    .init(
      avatar: "avatar",
      name: "name",
      hasBeenSeen: false,
      isLiked: false
    )
  }
}
