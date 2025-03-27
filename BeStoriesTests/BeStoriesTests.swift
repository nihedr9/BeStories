//
//  BeStoriesTests.swift
//  BeStoriesTests
//
//  Created by Nihed Majdoub on 27/03/2025.
//

import Testing
@testable import BeStories

struct BeStoriesTests {
  
  @Test func example() async throws {
    let dataService = DataFetcher.shared
    let users = try dataService.fetchUsers(fileName: "users")
    #expect(users.count > 0)
  }
}
