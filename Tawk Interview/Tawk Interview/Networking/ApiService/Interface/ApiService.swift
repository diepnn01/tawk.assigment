//
//  ApiService.swift
//  Tawk Interview
//
//  Created by Diep Nguyen on 21/05/2022.
//

import Foundation
import Combine
protocol ApiService {
    func getUsers(with params: GetUsersParams) -> Future<ApiResponse<[UserEntity]>,Never>
    func getUser(with params: GetUserParams) -> Future<ApiResponse<UserEntity>,Never>
}
