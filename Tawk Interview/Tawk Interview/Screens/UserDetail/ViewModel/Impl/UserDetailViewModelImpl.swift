//
//  UserDetailViewModelImpl.swift
//  Tawk Interview
//
//  Created by Diep Nguyen on 22/05/2022.
//

import Foundation
import Combine

class UserDetailViewModelImpl: NSObject, UserDetailViewModel {
    
    var onGetUser: PassthroughSubject<UserEntity?, Never> = PassthroughSubject<UserEntity?, Never>()
    var onGetNote: PassthroughSubject<String?, Never> = PassthroughSubject<String?, Never>()
    var stores = Set<AnyCancellable>()
    var apiService: ApiService!
    var persistence: PersistenceController
    var model: UserDetailModel
    init(model: UserDetailModel, apiService: ApiService, persistence: PersistenceController) {
        self.apiService = apiService
        self.model = model
        self.persistence = persistence
    }

    func getUserDetail() {
        persistence.insertOrUpdate(selected: model.userName)
        persistence.getUser(with: model.userName)
            .zip(persistence.getUserNote(of: model.userName))
            .sink(receiveValue: { (user, note) in
                if let user = user {
                    self.onGetUser.send(user)
                    self.onGetNote.send(note?.note)
                } else {
                    self.getUserFromRemote()
                }
            })
            .store(in: &stores)
    }
    func getUserFromRemote() {
        self.apiService
            .getUser(with: GetUserParams(userName: self.model.userName))
            .sink { response in
                self.onGetUser.send(response.data)
                if let user = response.data {
                    self.persistence.insertOrUpdate(user: user)
                }
            }.store(in: &stores)

    }
    func saveNote(with text: String) {
        persistence.insertOrUpdate(note: text, of: model.userName)
    }
    
}
