//
//  PersistenceController+SyncData.swift
//  Tawk Interview
//
//  Created by Diep Nguyen on 22/05/2022.
//

import Foundation
import CoreData
import Combine
extension PersistenceController {
    func insertOrUpdate(user: UserEntity) {
        guard let userId = user.id else {return}
        syncDataContext.perform {
            let request = UserEntry.fetchRequest()
            request.predicate = NSPredicate(format: "id == %d", userId)
            request.fetchLimit = 1
            if let userEntry = try? request.execute().first {
                userEntry.updateData(user: user)
            } else if let entity = NSEntityDescription.entity(forEntityName: EntityName.UserEntry.rawValue, in: self.syncDataContext) {
                let userEntry = UserEntry(entity: entity, insertInto: self.syncDataContext)
                userEntry.updateData(user: user)
                self.syncDataContext.insert(userEntry)
            }
            try? self.syncDataContext.save()
        }
    }
    
    func insertOrUpdate(note: String?, of userName: String) {
        syncDataContext.perform {
            let request = UserNoteEntry.fetchRequest()
            request.predicate = NSPredicate(format: "user_name == %@", userName)
            request.fetchLimit = 1
            if let userEntry = try? request.execute().first {
                userEntry.note = note
            } else if let entity = NSEntityDescription.entity(forEntityName: EntityName.UserNoteEntry.rawValue, in: self.syncDataContext) {
                let userEntry = UserNoteEntry(entity: entity, insertInto: self.syncDataContext)
                userEntry.note = note
                userEntry.user_name = userName
                self.syncDataContext.insert(userEntry)
            }
            try? self.syncDataContext.save()
        }
    }
    func insertOrUpdate(selected userName: String) {
        syncDataContext.perform {
            let request = UserSelected.fetchRequest()
            request.predicate = NSPredicate(format: "user_name == %@", userName)
            request.fetchLimit = 1
            if let userEntry = try? request.execute().first {
                print(userEntry)
            } else if let entity = NSEntityDescription.entity(forEntityName: EntityName.UserSelected.rawValue, in: self.syncDataContext) {
                let userEntry = UserSelected(entity: entity, insertInto: self.syncDataContext)
                userEntry.user_name = userName
                self.syncDataContext.insert(userEntry)
            }
            try? self.syncDataContext.save()
        }
    }

}
