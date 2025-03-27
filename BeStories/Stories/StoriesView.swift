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
  
  @State private var router = Router()
  
  var body: some View {
    NavigationStack(path: $router.paths) {
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
            action: { story, namespace in
              router.presentedSheet = .storyDetails(story: story, namespace: namespace)
              viewModel.updateHasBeenSeen(story: story, hasBeenSeen: true)
            },
            loadMore: { await viewModel.loadMoreStories() })
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
      .sheet(item: $router.presentedSheet) { destination in
        switch destination {
        case .storyDetails(let story, let namespace):
          StoryDetailsView()
            .navigationTransition(.zoom(sourceID: story.id, in: namespace))
        }
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
