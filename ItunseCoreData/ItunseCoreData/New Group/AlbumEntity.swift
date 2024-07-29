//
//  AlbumEntity.swift
//  ItunseCoreData
//
//  Created by Рахим Габибли on 24.07.2024.
//

import Foundation
import CoreData

class AlbumEntity: NSManagedObject {

    class func findOrCreate(_ album: Album, context: NSManagedObjectContext) throws -> AlbumEntity {

        let request = AlbumEntity.fetchRequest()
        request.predicate = NSPredicate(format: "artistId = %d", album.artistId)

        do {
            let fetchResult = try context.fetch(request)

            if fetchResult.count > 0 {
                if fetchResult.count > 1 {
                    print("Warning: Duplicate entries found for artistId: \(album.artistId)")
                }
                return fetchResult[0]
            }
        } catch {
            throw error
        }

        let albumEntity = AlbumEntity(context: context)
        albumEntity.artistId = Int64(album.artistId)
        albumEntity.albumName = album.collectionName
        albumEntity.artistName = album.artistName
        albumEntity.imageUrl = album.artworkUrl100
        albumEntity.trackCount = "\(album.trackCount)"

        return albumEntity
    }

    class func all(_ context: NSManagedObjectContext) throws -> [AlbumEntity] {

        let request: NSFetchRequest<AlbumEntity> = AlbumEntity.fetchRequest()

        do {
            return try context.fetch(request)
        } catch {
            throw error
        }
    }

    class func deleteAll(_ context: NSManagedObjectContext) throws {
        let request: NSFetchRequest<NSFetchRequestResult> = AlbumEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)

        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            throw error
        }
    }
}

//class AlbumEntity: NSManagedObject {
//
//    class func findOrCreate(_ album: Album, context: NSManagedObjectContext) throws -> AlbumEntity {
//
//        let request = AlbumEntity.fetchRequest()
//        request.predicate = NSPredicate(format: "artistId = %d", album.artistId)
//
//        do {
//            let fetchResult = try context.fetch(request) //
//
//            if fetchResult.count > 0 {
//                assert(fetchResult.count == 1, "Duplicate")
//                return fetchResult[0]
//            }
//        } catch {
//            throw error
//        }
//
//        let albumEntity = AlbumEntity(context: context)
//        albumEntity.artistId = Int64(album.artistId)
//        albumEntity.albumName = album.collectionName
//        albumEntity.artistName = album.artistName
//        albumEntity.imageUrl = album.artworkUrl100
//        albumEntity.trackCount = "\(album.trackCount)"
//
//        return albumEntity
//    }
//
//    class func all(_ context: NSManagedObjectContext) throws ->  [AlbumEntity] {
//
//        let request: NSFetchRequest<AlbumEntity> = AlbumEntity.fetchRequest()
//
//        do {
//            return try context.fetch(request)
//        } catch {
//            throw error
//        }
//
//    }
//
//}
