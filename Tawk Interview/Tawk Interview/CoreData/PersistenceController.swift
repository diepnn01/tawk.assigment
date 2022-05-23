//
//  PersistenceController.swift
//  Tawk Interview
//
//  Created by Diep Nguyen on 22/05/2022.
//

import CoreData
import UIKit
import Combine
class PersistenceController {
    static let shared = PersistenceController()
    var stores = Set<AnyCancellable>()
    enum EntityName: String {
        case UserEntry
        case UserNoteEntry
        case UserSelected
    }
    
    private func getPrivateContext() -> NSManagedObjectContext {
        let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext.persistentStoreCoordinator = CoreDataStack.shared.context.persistentStoreCoordinator
        return privateContext
    }
    private(set) lazy var syncDataContext: NSManagedObjectContext = {
        return self.getPrivateContext()
    }()
    private(set) lazy var fetchDataContext: NSManagedObjectContext = {
        return self.getPrivateContext()
    }()

}
