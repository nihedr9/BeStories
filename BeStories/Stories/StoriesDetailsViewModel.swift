//
//  StoriesDetailsViewModel.swift
//  BeStories
//
//  Created by Nihed Majdoub on 27/03/2025.
//

import SwiftUI
import Database
import Model

@MainActor
@Observable
public final class StoriesDetailsViewModel {
  
  let database: DatabaseService
  let story: Story

  private let duration = 5.0
  
  let progressInterval: ClosedRange<Date>
  
  private(set) var timer: Timer?
  
  init(story: Story, database: any DatabaseService) {
    self.story = story
    self.database = database
    let now = Date.now
    progressInterval = now...now.addingTimeInterval(duration)
  }
  
  func toggleIsLiked() {
    do {
      try database.toggleIsLiked(story: story)
    } catch {
      // TODO: implement an error alert toast
    }
  }
  
  func scheduleTimer(action: @escaping () -> Void) {
    timer = Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { _ in
      action()
    }
  }
  
  func invalidateTimer() {
    timer?.invalidate()
    timer = nil
  }
}
