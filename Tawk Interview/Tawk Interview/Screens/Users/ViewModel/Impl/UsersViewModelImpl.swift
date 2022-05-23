//
//  UsersViewModelImpl.swift
//  Tawk Interview
//
//  Created by Diep Nguyen on 21/05/2022.
//

import Foundation
import Combine
class UsersViewModelImpl: NSObject, UsersViewModel {
    var onNewUsers: PassthroughSubject<[UserEntity], Never> = PassthroughSubject<[UserEntity], Never>()
    var onMoreUsers: PassthroughSubject<[UserEntity], Never> = PassthroughSubject<[UserEntity], Never>()
    var onSearchUsers: PassthroughSubject<[UserEntity], Never> = PassthroughSubject<[UserEntity], Never>()
    var model: UsersModel
    var stores = Set<AnyCancellable>()
    var apiService: ApiService!
    var persistence: PersistenceController
    init(model: UsersModel, apiService: ApiService, persistence: PersistenceController) {
        self.apiService = apiService
        self.model = model
        self.persistence = persistence
    }
    func search(text: String) {
        let results = model.users.filter({
            $0.login?.contains(text) == true || $0.nodeID?.contains(text) == true
        })
        self.onSearchUsers.send(results)
    }
    func getUsers() {
        getUsersfromLocal()
    }
    
    func getUsersfromLocal() {
        persistence.getUsers()
            .sink { [weak self] users in
                if !users.isEmpty {
                    self?.onNewUsers.send(users)
                    self?.model.users = users
                } else {
                    self?.getUserFromRemote()
                }
            }.store(in: &stores)
    }
    
    func getUserFromRemote() {
        apiService.getUsers(with: GetUsersParams(since: 0))
            .sink { [weak self] response in
                if let users = response.data {
                    self?.onNewUsers.send(users)
                } else {
                    self?.onNewUsers.send([])
                }
                self?.model.users = response.data ?? []
            }.store(in: &stores)
    }
    
    func getMoreUser(from user: UserEntity) {
        guard let id = user.id else {return}
        apiService.getUsers(with: GetUsersParams(since: id))
            .sink { [weak self]response in
                if let users = response.data {
                    self?.onMoreUsers.send(users)
                } else {
                    self?.onMoreUsers.send([])
                }
                self?.model.users.append(contentsOf: response.data ?? [])
            }.store(in: &stores)
    }
    
    
}
