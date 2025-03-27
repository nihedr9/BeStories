//
//  ContentView.swift
//  BeStories
//
//  Created by Nihed Majdoub on 27/03/2025.
//

import SwiftUI
import Network
import Model
import DesignSystem

struct StoriesView: View {
  
  let viewModel: StoriesViewModelProtocol
  
  var body: some View {
    NavigationStack {
      VStack {
        switch viewModel.state {
        case .loading:
          loadingView
        case .failed(let error):
          // TODO: implement error views
          Text("Error: \(error)")
        case .loaded(let stories):
          StoriesListView(
            stories: stories,
            hasMoreStories: viewModel.hasMoreStories,
            action: { await viewModel.loadMoreStories() })
          .padding(8)
        case .idle:
          Color.clear
        }
        
        Spacer()
      }
      .toolbarColorScheme(.dark, for: .navigationBar)
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Image("logo")
            .resizable()
            .scaledToFit()
            .frame(width: 100)
        }
      }
      .task {
        await viewModel.fetchStories()
      }
    }
  }
  
  private var loadingView: some View {
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
