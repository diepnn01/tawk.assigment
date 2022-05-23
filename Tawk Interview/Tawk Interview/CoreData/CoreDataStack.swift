//
//  CoreDataStack.swift
//  Tawk Interview
//
//  Created by Diep Nguyen on 21/05/2022.
//

import Foundation
import CoreData
class CoreDataStack {
  static let shared = CoreDataStack()
  let modelName = "Tawk_Interview"
  private lazy var applicationDocumentsDirectory: NSURL = {
      let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
      return url! as NSURL
  }()

  //1
  lazy var context: NSManagedObjectContext = {
    var managedObjectContext = NSManagedObjectContext(
      concurrencyType: .mainQueueConcurrencyType)
    managedObjectContext.persistentStoreCoordinator = self.psc
    return managedObjectContext
  }()

  private lazy var psc: NSPersistentStoreCoordinator = {
    let new_version = 1
    let version = 1
    if version < new_version {
        print("RESET CoreData Version: \(version) -> \(new_version)")
        let dbUrls = [self.applicationDocumentsDirectory.appendingPathComponent(self.modelName)!, self.applicationDocumentsDirectory.appendingPathComponent(self.modelName + "-shm")!, self.applicationDocumentsDirectory.appendingPathComponent(self.modelName + "-wal")!]
        for url in dbUrls {
            print("DELETE url \(url): ", (try? FileManager.default.removeItem(at: url)) != nil)
        }
    }
    let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
    let url = self.applicationDocumentsDirectory
      .appendingPathComponent(self.modelName)
    do {
        let options = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]
      try coordinator.addPersistentStore( ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
    } catch {
      print("Error adding persistent store.")
    }
    return coordinator
  }()

  //3
  private lazy var managedObjectModel: NSManagedObjectModel = {
    let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "momd")!
    return NSManagedObjectModel(contentsOf: modelURL)!
  }()

  func saveContext () {
    if context.hasChanges {
      do {
        try context.save()
      } catch let error as NSError {
        print("Error: \(error.localizedDescription)")
        abort()
      }
    }
  }
}
