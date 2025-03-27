//
//  Router.swift
//  BeStories
//
//  Created by Nihed Majdoub on 27/03/2025.
//

import SwiftUI
import Model

@MainActor
@Observable
public final class Router {
  
  public var paths: [RouterDestination] = []
  public var presentedSheet: SheetDestination?
  
  public init() {}
  
  public func navigate(to destination: RouterDestination) {
    paths.append(destination)
  }
}

public enum RouterDestination: Identifiable, Hashable {
  
  public static func == (lhs: RouterDestination, rhs: RouterDestination) -> Bool {
    lhs.id == rhs.id
  }
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
  case placeholder
  
  public var id: String {
    switch self {
    case .placeholder:
      "placeholder"
    }
  }
}

public enum SheetDestination: Identifiable, Hashable {
  
  public static func == (lhs: SheetDestination, rhs: SheetDestination) -> Bool {
    lhs.id == rhs.id
  }
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
  case storyDetails(story: Story, namespace: Namespace.ID)
  
  public var id: String {
    switch self {
    case .storyDetails(let story, _):
      "storyDetails \(story.id)"
    }
  }
}
