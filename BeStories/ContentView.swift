//
//  ContentView.swift
//  BeStories
//
//  Created by Nihed Majdoub on 27/03/2025.
//

import SwiftUI
import Network
import Model

struct ContentView: View {
    
  @State var stories: [Story] = []
  
  var body: some View {
    NavigationStack {
      VStack {
        StoriesListView(stories: stories)
          .padding(8)
        
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
    }
  }
}

#Preview {
  ContentView()
}
