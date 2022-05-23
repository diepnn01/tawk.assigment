//
//  UserEntry+Extension.swift
//  Tawk Interview
//
//  Created by Diep Nguyen on 22/05/2022.
//

import CoreData
extension UserEntry {
    func toModel() -> UserEntity {
        return UserEntity(login: login,
                              id: Int(id),
                              nodeID: node_id,
                              avatarURL: avatar_url,
                              gravatarID: gravatar_id,
                              url: url,
                              htmlURL: html_url,
                              followersURL: followers_url,
                              followingURL: following_url,
                              gistsURL: gists_url,
                              starredURL: starred_url,
                              subscriptionsURL: subscriptions_url,
                              organizationsURL: organizations_url,
                              reposURL: repos_url,
                              eventsURL: events_url,
                              receivedEventsURL: received_events_url,
                              type: type,
                              siteAdmin: site_admin,
                              name: name,
                              company: company,
                              blog: blog,
                              location: location,
                              email: email,
                              hireable: hireable,
                              bio: bio,
                              twitterUsername: twitter_username,
                              publicRepos: Int(public_repos),
                              publicGists: Int(public_gists),
                              followers: Int(followers),
                              following: Int(following)
        )
    }
    func updateData(user: UserEntity) {
        self.id = user.id?.toInt64() ?? -1
        self.login = user.login
        self.node_id = user.nodeID
        self.gravatar_id = user.gravatarID
        self.url = user.url
        self.html_url = user.htmlURL
        self.followers_url = user.followersURL
        self.following_url = user.followingURL
        self.gists_url = user.gistsURL
        self.starred_url = user.starredURL
        self.subscriptions_url = user.subscriptionsURL
        self.organizations_url = user.organizationsURL
        self.repos_url = user.reposURL
        self.events_url = user.eventsURL
        self.received_events_url = user.receivedEventsURL
        self.type = user.type
        self.site_admin = user.siteAdmin ?? false
        self.name = user.name
        self.company = user.company
        self.blog = user.blog
        self.location = user.location
        self.email = user.email
        self.hireable = user.hireable
        self.bio = user.bio
        self.twitter_username = user.twitterUsername
        self.public_repos = user.publicRepos?.toInt64() ?? -1
        self.public_gists = user.publicGists?.toInt64() ?? -1
        self.followers = user.followers?.toInt64() ?? 0
        self.following = user.following?.toInt64() ?? 0
        self.avatar_url = user.avatarURL
    }
}
