//
//  UsersViewModel.swift
//  Tawk Interview
//
//  Created by Diep Nguyen on 21/05/2022.
//

import Foundation
import Combine
protocol UsersViewModel {
    var onNewUsers: PassthroughSubject<[UserEntity], Never> {get}
    var onMoreUsers: PassthroughSubject<[UserEntity], Never> {get}
    var onSearchUsers: PassthroughSubject<[UserEntity], Never> {get}
    var model: UsersModel {get}
    func getUsers()
    func getMoreUser(from user: UserEntity)
    func search(text: String)
}
