//
//  UsersDataSource.swift
//  Tawk Interview
//
//  Created by Diep Nguyen on 21/05/2022.
//

import UIKit
import Combine
protocol UsersDataSource {
    var onTap: PassthroughSubject<UserEntity, Never> {get}
    var onGetMore: PassthroughSubject<UserEntity, Never> {get}
    func attach(tableView: UITableView)
    func changeMode(state: DisplayState)
    func setDataSource(_ users: [UserEntity])
    func onAddMoreDataSource(_ users: [UserEntity])
    func onSearch(_ users: [UserEntity])
}
