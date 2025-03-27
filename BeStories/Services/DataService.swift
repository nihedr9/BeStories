//
//  DataService.swift
//  BeStories
//
//  Created by Nihed Majdoub on 27/03/2025.
//

import Foundation

public protocol DataService {
  func fetchUsers(fileName: String) throws -> [UserModel]
}

public enum DataServiceError: Error {
  case fileNotFound
  case decodingError
}

public struct DataFetcher: DataService {
  
  static let shared = DataFetcher()
  
  private init() {}
  
  public func fetchUsers(fileName: String = "users") throws(DataServiceError) ->  [UserModel] {
    do {
      guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
        throw DataServiceError.fileNotFound
      }
      let response: UsersResponse = try readJSON(with: url)
      return response.pages.flatMap { $0.users }
    } catch {
      throw DataServiceError.decodingError
    }
  }
}

extension DataFetcher {
  private func readJSON<T: Decodable>(with url: URL) throws -> T {
    let data = try Data(contentsOf: url)
    return try JSONDecoder().decode(T.self, from: data)
  }
}
