//
//  UsersViewController.swift
//  Tawk Interview
//
//  Created by Diep Nguyen on 21/05/2022.
//

import UIKit
import Combine
class UsersViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var viewModel: UsersViewModel!
    var dataSource: UsersDataSource!
    var stores = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        onHandelViewModel()
        onHandleDataSource()
        setupData()
        if let reachability = AppDependency.shared.reachability {
            NotificationCenter.default.publisher(for: .reachabilityChanged, object: reachability)
                .sink { notification in
                    let reachability = notification.object as? Reachability
                    switch reachability?.connection {
                    case .wifi, .cellular:
                        self.viewModel.getUsers()
                    case .unavailable:
                        self.showNetworkAlert()
                    default: break
                    }
                    
                }.store(in: &stores)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    func setup() {
        if self.navigationController?.viewControllers.first == self { // init when first screen from storyboard
            viewModel = UsersViewModelImpl(model: UsersModel(), apiService: AppDependency.shared.appApi, persistence: AppDependency.shared.persistence)
            dataSource = UsersDataSourceImpl()
        }
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        self.dataSource.attach(tableView: tableView)
    }

    func onHandelViewModel() {
        viewModel.onNewUsers
            .receive(on: DispatchQueue.main)
            .sink { [weak self]users in
            self?.dataSource.setDataSource(users)
        }.store(in: &stores)
        viewModel.onMoreUsers
            .receive(on: DispatchQueue.main)
            .sink { [weak self]users in
            self?.dataSource.onAddMoreDataSource(users)
        }.store(in: &stores)
        viewModel.onSearchUsers
            .receive(on: DispatchQueue.main)
            .sink { users in
                self.dataSource.onSearch(users)
            }.store(in: &stores)
    }
    
    func onHandleDataSource() {
        dataSource.onTap.sink {[weak self] user in
            self?.openDetailUser(with: user.login ?? "")
        }.store(in: &stores)
        dataSource.onGetMore.sink {[weak self] user in
            self?.viewModel.getMoreUser(from: user)
        }.store(in: &stores)
    }
    
    func setupData() {
        self.viewModel.getUsers()
    }
    
    func openDetailUser(with userName: String) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserDetailViewController") as? UserDetailViewController else {
            return
        }
        vc.viewModel = UserDetailViewModelImpl(model: UserDetailModel(userName: userName), apiService: AppDependency.shared.appApi, persistence: AppDependency.shared.persistence)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension UsersViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.search(text: searchBar.text ?? "")
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.dataSource.changeMode(state: .search)
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if (searchBar.text ?? "").isEmpty {
            self.dataSource.changeMode(state: .normal)
        }
    }
}
