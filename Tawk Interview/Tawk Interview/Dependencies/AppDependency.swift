//
//  AppDependency.swift
//  Tawk Interview
//
//  Created by Diep Nguyen on 21/05/2022.
//

import Foundation
class AppDependency {
    static let shared = AppDependency()
    let reachability = try? Reachability()
    lazy var persistence: PersistenceController = {
        return PersistenceController.shared
    }()
    lazy var appApi: ApiService = {
        return ApiServiceImpl()
    }()
}
