//
//  UserDetailViewModel.swift
//  Tawk Interview
//
//  Created by Diep Nguyen on 22/05/2022.
//

import Foundation
import Combine
protocol UserDetailViewModel: class {
    var onGetUser: PassthroughSubject<UserEntity?, Never> {get}
    var onGetNote: PassthroughSubject<String?, Never> {get}
    func getUserDetail()
    func saveNote(with text: String)
}
