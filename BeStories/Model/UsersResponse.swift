//
//  UsersResponse.swift
//  BeStories
//
//  Created by Nihed Majdoub on 27/03/2025.
//

public struct UserModel: Codable {
  public let id: Int
  public let name: String
  public let avatar: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case avatar = "profile_picture_url"
  }
}

struct Page: Codable {
  let users: [UserModel]
}

struct UsersResponse: Codable {
  let pages: [Page]
}
