//
//  CoreDataManager.swift
//  ItunseCoreData
//
//  Created by Рахим Габибли on 29.07.2024.
//

import Foundation
import CoreData

class CoreDataManager {

    static let shared = CoreDataManager()

    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "ItunseCoreData")
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    private init() {}

    func getAllAlbums(_ complition: @escaping ([Album]) -> Void) {
        let viewContext = persistentContainer.viewContext

        viewContext.perform {
            let albumEntities = try? AlbumEntity.all(viewContext)
            let dbAlbums = albumEntities?.map({ Album(entity: $0) })

            complition(dbAlbums ?? [])
        }
    }

    func save(albums: [Album], completion: @escaping () -> Void) {
         let context = persistentContainer.viewContext

         context.perform {
             do {
                 try AlbumEntity.deleteAll(context)

                 for album in albums {
                     _ = try AlbumEntity.findOrCreate(album, context: context)
                 }

                 try context.save()
                 completion()
             } catch {
                 print("Failed to save albums: \(error)")
                 completion()
             }
         }
     }

    func getAllSearchText(_ completion: @escaping ([String]) -> Void) {
        let viewContext = persistentContainer.viewContext

        viewContext.perform {
            do {
                let searchTextEntities = try SearchTextEntity.all(viewContext)
                let dbSearchTexts = searchTextEntities.compactMap { $0.searchText }
                completion(dbSearchTexts)
            } catch {
                print("Error fetching search texts: \(error.localizedDescription)")
                completion([])
            }
        }
    }

    func save(texts: [String], completion: @escaping () -> Void) {
         let context = persistentContainer.viewContext

         context.perform {
             do {
                 for text in texts {
                     _ = try SearchTextEntity.findOrCreate(text, context: context)
                 }
                 try context.save()
                 completion()
             } catch {
                 print("Failed to save albums: \(error)")
                 completion()
             }
         }
     }

    func update(text: String) {
        getAllSearchText { [weak self] texts in
            var searchTexts = texts
            searchTexts.append(text)
            self?.save(texts: searchTexts) {

            }
        }
    }
}
