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
  
  let stories = Story.placeholders
  
  var body: some View {
      ScrollView(.horizontal) {
        LazyHStack(spacing: 8) {
          ForEach(stories) { story in
            Button(action: { }) {
              StoryView(item: .init(from: story))
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
  StoriesListView()
}
