//
//  ContentView.swift
//  BeStories
//
//  Created by Nihed Majdoub on 27/03/2025.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationStack {
      VStack {
        StoriesListView()
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
