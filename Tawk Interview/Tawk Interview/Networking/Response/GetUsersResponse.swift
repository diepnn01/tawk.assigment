//
//  GetUsersResponse.swift
//  Tawk Interview
//
//  Created by Diep Nguyen on 21/05/2022.
//

import Foundation
struct GetUsersResponse: Codable {
    let users: [UserEntity]
    init(from decoder: Decoder) throws {
            let value = try decoder.singleValueContainer()
            users = try value.decode([UserEntity].self)
        }
}
