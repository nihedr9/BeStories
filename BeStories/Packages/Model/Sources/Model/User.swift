//
//  User.swift
//  BeStories
//
//  Created by Nihed Majdoub on 27/03/2025.
//

public class User: Identifiable {
  
  public var id: String
  public var name: String
  public var avatar: String
  
  public init(
    id: String,
    name: String,
    avatar: String
  ) {
    self.id = id
    self.name = name
    self.avatar = avatar
  }
  
  public convenience init(user: UserModel) {
    self.init(
      id: "\(user.id)",
      name: user.name,
      avatar: user.avatar )
  }
}
