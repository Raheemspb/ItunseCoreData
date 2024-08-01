//
//  SearchTextEntity.swift
//  ItunseCoreData
//
//  Created by Рахим Габибли on 30.07.2024.
//

import Foundation
import CoreData

class SearchTextEntity: NSManagedObject {

    class func findOrCreate(_ searchText: String, context: NSManagedObjectContext) throws -> SearchTextEntity {

        let request = SearchTextEntity.fetchRequest()
        request.predicate = NSPredicate(format: "searchText = %@", searchText)

        do {
            let fetchResult = try context.fetch(request)
            if let existingEntity = fetchResult.first {
                return existingEntity
            }
        } catch {
            throw error
        }

        let searchTextEntity = SearchTextEntity(context: context)
        searchTextEntity.searchText = searchText

        return searchTextEntity
    }

    class func all(_ context: NSManagedObjectContext) throws -> [SearchTextEntity] {

        let request: NSFetchRequest<SearchTextEntity> = SearchTextEntity.fetchRequest()

        do {
            return try context.fetch(request)
        } catch {
            throw error
        }
    }
}
