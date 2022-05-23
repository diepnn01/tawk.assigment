//
//  Number+Extension.swift
//  Tawk Interview
//
//  Created by Diep Nguyen on 22/05/2022.
//

import Foundation
extension Int {
    func toInt64() -> Int64 {
        return Int64(self)
    }
    func toInt32() -> Int32 {
        return Int32(self)
    }
    func toInt16() -> Int16 {
        return Int16(self)
    }
}

extension Int64 {
    func toInt() -> Int {
        return Int(self)
    }
    func toInt32() -> Int32 {
        return Int32(self)
    }
    func toInt16() -> Int16 {
        return Int16(self)
    }
}
