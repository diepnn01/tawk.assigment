//
//  ApiResponse.swift
//  Tawk Interview
//
//  Created by Diep Nguyen on 21/05/2022.
//

import Foundation
struct ApiResponse<T: Codable> {
    var data: T?
    var error: ApiError?
}
