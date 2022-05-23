//
//  UsersCellViewModelImpl.swift
//  Tawk Interview
//
//  Created by Diep Nguyen on 22/05/2022.
//

import Foundation
import Combine
class UsersCellViewModelImpl: NSObject, UsersCellViewModel {
    var onCheckSelected = PassthroughSubject<Bool, Never>()
    
    var onGetUser = PassthroughSubject<UserEntity?, Never>()
    var onGetNote = PassthroughSubject<String?, Never>()
    var model: UsersCellModel
    var api: ApiService
    var persistence: PersistenceController
    var stores = Set<AnyCancellable>()
    init(model: UsersCellModel, api: ApiService, persistence: PersistenceController) {
        self.model = model
        self.api = api
        self.persistence = persistence
    }
    func loadData() {
        persistence.getUser(with: model.id)
            .zip(persistence.getUserNote(of: model.id))
            .sink(receiveValue: { user, note in
                if let user = user {
                    self.onGetUser.send(user)
                    self.onGetNote.send(note?.note)
                } else {
                    self.getUserFromRemote()
                }
            })
            .store(in: &stores)
        persistence.userSelected(of: model.id)
            .sink(receiveValue: { selected in
                print(self.model.id)
                print(selected)
                self.onCheckSelected.send(selected)
            })
            .store(in: &stores)
    }
    func getUserFromRemote() {
        self.api
            .getUser(with: GetUserParams(userName: self.model.id))
            .sink { response in
                self.onGetUser.send(response.data)
                if let user = response.data {
                    self.persistence.insertOrUpdate(user: user)
                }
            }.store(in: &stores)

    }
}
