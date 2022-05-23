//
//  ApiServiceImpl.swift
//  Tawk Interview
//
//  Created by Diep Nguyen on 21/05/2022.
//

import Foundation
import Combine
class ApiServiceImpl: ApiService {
    private var apiQueue = DispatchQueue(label: "com.api.queue")
    var semaphore = DispatchSemaphore(value: 1)
    func getUsers(with params: GetUsersParams) -> Future<ApiResponse<[UserEntity]>, Never> {
        Future { promise in
            let task = DispatchWorkItem {
                var components = URLComponents(string: "https://api.github.com/users")!
                components.queryItems = [
                    URLQueryItem(name: "since", value: "\(params.since)")
                ]
                components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
                var request = URLRequest(url: components.url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 30)
                request.httpMethod = "GET"
                self.semaphore.wait()
                URLSession.shared.dataTask(with: request) { data, response, error in
                    self.semaphore.signal()
                    guard let data = data, error == nil else {
                        promise(.success(ApiResponse(data: nil, error: ApiError(message: error?.localizedDescription ?? "Unknow error", type: .user, errorCodde: "101"))))
                        return
                    }
                    let result = try? newJSONDecoder().decode([UserEntity].self, from: data)
                    promise(.success(ApiResponse(data: result, error: nil)))
                }.resume()
            }
            self.apiQueue.async(execute: task)
        }
    }
    
    func getUser(with params: GetUserParams) -> Future<ApiResponse<UserEntity>, Never> {
        Future { promise in
            let task = DispatchWorkItem {
                self.semaphore.wait()
                var url = URL(string: "https://api.github.com/users")!
                url.appendPathComponent(params.userName)
                var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 30)
                request.httpMethod = "GET"
                URLSession.shared.dataTask(with: request) { data, response, error in
                    self.semaphore.signal()
                    guard let data = data, error == nil else {
                        promise(.success(ApiResponse(data: nil, error: ApiError(message: error?.localizedDescription ?? "Unknow error", type: .user, errorCodde: "101"))))
                        return
                    }
                    let result = try? newJSONDecoder().decode(UserEntity.self, from: data)
                    promise(.success(ApiResponse(data: result, error: nil)))
                }.resume()
            }
            self.apiQueue.async(execute: task)
        }
    }
    
    
}
