//
//  UsersCellViewModel.swift
//  Tawk Interview
//
//  Created by Diep Nguyen on 22/05/2022.
//

import Foundation
import Combine
protocol UsersCellViewModel: class {
    var onGetUser: PassthroughSubject<UserEntity?, Never> {get}
    var onGetNote: PassthroughSubject<String?, Never> {get}
    var onCheckSelected: PassthroughSubject<Bool, Never> {get}
    func loadData()
}
