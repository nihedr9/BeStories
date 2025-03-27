//
//  BeStoriesTests.swift
//  BeStoriesTests
//
//  Created by Nihed Majdoub on 27/03/2025.
//

import Testing
import Network
import Database
import Model
@testable import BeStories
import SwiftData

struct BeStoriesTests {
  
  @Test
  func fetchUsers() async throws {
    let dataService = DataFetcher.shared
    let users = try dataService.fetchUsers()
    #expect(users.count > 0)
  }
}
