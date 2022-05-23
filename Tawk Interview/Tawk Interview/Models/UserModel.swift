//
//  UserModel.swift
//  Tawk Interview
//
//  Created by Diep Nguyen on 21/05/2022.
//

import Foundation
class UserEntity: Codable {
    var login: String?
    var id: Int?
    var nodeID: String?
    var avatarURL: String?
    var gravatarID: String?
    var url, htmlURL, followersURL: String?
    var followingURL, gistsURL, starredURL: String?
    var subscriptionsURL, organizationsURL, reposURL: String?
    var eventsURL: String?
    var receivedEventsURL: String?
    var type: String?
    var siteAdmin: Bool?
    var name, company: String?
    var blog: String?
    var location: String?
    var email, hireable, bio, twitterUsername: String?
    var publicRepos, publicGists, followers, following: Int?

    init (login: String?,
          id: Int?,
          nodeID: String?,
          avatarURL: String?,
          gravatarID: String?,
          url: String?,
          htmlURL: String?,
          followersURL: String?,
          followingURL: String?,
          gistsURL: String?,
          starredURL: String?,
          subscriptionsURL: String?,
          organizationsURL: String?,
          reposURL: String?,
          eventsURL: String?,
          receivedEventsURL: String?,
          type: String?,
          siteAdmin: Bool?,
          name: String?,
          company: String?,
          blog: String?,
          location: String?,
          email: String?,
          hireable: String?,
          bio: String?,
          twitterUsername: String?,
          publicRepos: Int?,
          publicGists: Int?,
          followers: Int?,
          following: Int?) {
        self.login = login
        self.id = id
        self.name = name
        self.nodeID = nodeID
        self.avatarURL = avatarURL
        self.gravatarID = gravatarID
        self.url = url
        self.htmlURL = htmlURL
        self.followingURL = followingURL
        self.followersURL = followersURL
        self.gistsURL = gistsURL
        self.starredURL = starredURL
        self.subscriptionsURL = subscriptionsURL
        self.organizationsURL = organizationsURL
        self.reposURL = reposURL
        self.eventsURL = eventsURL
        self.receivedEventsURL = receivedEventsURL
        self.type = type
        self.siteAdmin = siteAdmin
        self.company = company
        self.blog = blog
        self.location = location
        self.email = email
        self.hireable = hireable
        self.bio = bio
        self.twitterUsername = twitterUsername
        self.publicRepos = publicRepos
        self.publicGists = publicGists
        self.followers = followers
        self.following = following
    }

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
        case name, company, blog, location, email, hireable, bio
        case twitterUsername = "twitter_username"
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case followers, following
    }
}

