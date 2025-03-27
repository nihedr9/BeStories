//
//  StoriesListView.swift
//  BeStories
//
//  Created by Nihed Majdoub on 27/03/2025.
//

import SwiftUI
import DesignSystem
import Model

struct StoriesListView: View {
  
  let stories: [Story]
  let hasMoreStories: Bool
  let action: () async -> Void
  
  var body: some View {
    ScrollView(.horizontal) {
      LazyHStack(spacing: 8) {
        ForEach(stories) { story in
          Button(action: { }) {
            
            StoryView(item: .init(from: story))
            
            if story == stories.last, hasMoreStories {
              ForEach(Story.placeholders.prefix(2)) { story in
                StoryView(item: .init(from: story))
              }
              .redacted(reason: .placeholder)
              .task {
                await action()
              }
            }
          }
        }
      }
      .fixedSize()
    }
    .scrollClipDisabled()
    .scrollIndicators(.hidden)
  }
}

#Preview {
  StoriesListView(stories: Story.placeholders, hasMoreStories: false, action: {})
}
