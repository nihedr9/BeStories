//
//  StoriesLoadingView.swift
//  DesignSystem
//
//  Created by Nihed Majdoub on 27/03/2025.
//

import SwiftUI
import Model

public struct StoriesLoadingView: View {
  
  public init() {}
  
  public var body: some View {
    ScrollView(.horizontal) {
      LazyHStack(spacing: 8) {
        ForEach(Story.placeholders) { story in
          StoryView(item: .init(from: story))
        }
        .redacted(reason: .placeholder)
      }
      .fixedSize()
      .padding(8)
    }
  }
}

#Preview {
  StoriesLoadingView()
}
