//
//  UsersDataSourceImpl.swift
//  Tawk Interview
//
//  Created by Diep Nguyen on 21/05/2022.
//

import Combine
import UIKit
enum DisplayState {
    case loading
    case normal
    case search
}
class UsersDataSourceImpl: NSObject, UsersDataSource {
    weak var tableView: UITableView?
    var onTap: PassthroughSubject<UserEntity, Never> = PassthroughSubject<UserEntity, Never>()
    var onGetMore: PassthroughSubject<UserEntity, Never> = PassthroughSubject<UserEntity, Never>()
    var dataSource: [UserEntity] = []
    var searchDataSource: [UserEntity] = []
    var loadMoreView: LoadMoreActivityIndicator?
    var currentState: DisplayState = .loading {
        didSet {
            if currentState != oldValue {
                tableView?.reloadData()
            }
        }
    }

    func attach(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 54
        tableView.register(UINib(nibName: "UserItemCell", bundle: nil), forCellReuseIdentifier: "UserItemCell")
        loadMoreView = LoadMoreActivityIndicator(scrollView: tableView, spacingFromLastCell: tableView.contentInset.bottom, spacingFromLastCellWhenLoadMoreActionStart: 20)
        self.tableView = tableView
        
    }
    func setDataSource(_ users: [UserEntity]) {
        dataSource = users
        self.currentState = .normal
        tableView?.reloadData()
    }

    func onAddMoreDataSource(_ users: [UserEntity]) {
        if !users.isEmpty {
            dataSource.append(contentsOf: users)
            tableView?.reloadData()
        }
        loadMoreView?.stop()
    }
    func changeMode(state: DisplayState) {
        self.currentState = state
    }
    func onSearch(_ users: [UserEntity]) {
        self.searchDataSource = users
        tableView?.reloadSections(IndexSet(integer: 0), with: .automatic)
    }
    
}

extension UsersDataSourceImpl: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.currentState {
        case .loading:
            return 0
        case .normal:
            return dataSource.count
        case .search:
            return searchDataSource.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.currentState {
        case .loading:
            return loadingTableView(tableView, cellForRowAt: indexPath)
        case .normal:
            return normalTableView(tableView, cellForRowAt: indexPath)
        case .search:
            return searchTableView(tableView, cellForRowAt: indexPath)
        }
    }

    func searchTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserItemCell") as? UserItemCell else {
            return UITableViewCell()
        }
        cell.setUserInfo(searchDataSource[indexPath.row].login ?? "")
        return cell
    }

    func normalTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserItemCell") as? UserItemCell else {
            return UITableViewCell()
        }
        cell.setUserInfo(dataSource[indexPath.row].login ?? "")
        return cell
    }

    func loadingTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserItemCell") as? UserItemCell else {
            return UITableViewCell()
        }
//        cell.setUserInfo(dataSource[indexPath.row])
        return cell
    }

}

extension UsersDataSourceImpl: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch self.currentState {
        case .loading:
            return
        case .normal:
            let user = dataSource[indexPath.row]
            self.onTap.send(user)
            
        case .search:
            let user = searchDataSource[indexPath.row]
            self.onTap.send(user)
            
        }

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        loadMoreView?.start(closure: { [weak self] in
            if let user = self?.dataSource.last {
                self?.onGetMore.send(user)
            }
        })
    }
}
