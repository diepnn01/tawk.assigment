//
//  PersistenceController+FetchData.swift
//  Tawk Interview
//
//  Created by Diep Nguyen on 22/05/2022.
//

import Foundation
import Combine
import CoreData
extension PersistenceController {
    func getUsers() -> Future<[UserEntity], Never> {
        Future { promise in
            self.fetchDataContext.perform {
                let request = UserEntry.fetchRequest()
                if let users = try?request.execute() {
                    let usersModel = users.compactMap({$0.toModel()})
                    promise(.success(usersModel))
                } else {
                    promise(.success([]))
                }
            }
        }
    }

    func getUser(with userName: String) -> Future<UserEntity?, Never> {
        Future { promise in
            self.fetchDataContext.perform {
                let request = UserEntry.fetchRequest()
                request.predicate = NSPredicate(format: "login == %@", userName)
                request.fetchLimit = 1
                if let user = try?request.execute().first {
                    promise(.success(user.toModel()))
                } else {
                    promise(.success(nil))
                }
            }
        }
    }
    
    func getUserNote() -> Future<[UserNoteEntry], Never> {
        Future { promise in
            self.fetchDataContext.perform {
                let request = UserNoteEntry.fetchRequest()
                do {
                    promise(.success(try request.execute()))
                } catch {
                    promise(.success([]))
                }
            }
        }
    }
    
    func getUserNote(of userName: String) -> Future<UserNoteEntry?, Never> {
        Future { promise in
            self.fetchDataContext.perform {
                let request = UserNoteEntry.fetchRequest()
                request.predicate = NSPredicate(format: "user_name == %@", userName)
                request.fetchLimit = 1
                do {
                    promise(.success(try request.execute().first))
                } catch {
                    promise(.success(nil))
                }
            }
        }
    }
    func userSelected(of userName: String) -> Future<Bool, Never> {
        Future { promise in
            self.fetchDataContext.perform {
                let request = UserSelected.fetchRequest()
                request.predicate = NSPredicate(format: "user_name == %@", userName)
                do {
                    let users = try request.execute()
                    promise(.success(!users.isEmpty))
                } catch {
                    promise(.success(false))
                }
            }
        }
    }

}
