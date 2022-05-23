//
//  ApiError.swift
//  Tawk Interview
//
//  Created by Diep Nguyen on 21/05/2022.
//

import Foundation
enum ErrorType {
    case intenet
    case auth
    case user
    case server
}
struct ApiError {
    var message: String
    var type: ErrorType
    var errorCodde: String
}
