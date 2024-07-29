//
//  DataManager.swift
//  ItunseCoreData
//
//  Created by Рахим Габибли on 29.07.2024.
//

import Foundation

final class DataManager {
    let coreDataManager = CoreDataManager.shared
    let networkManager = NetworkManager()
    var albums = [Album]()

    func getAlbums(albumName: String, completion: @escaping ([Album]) -> Void) {
        // Сначала пытаемся получить альбомы из Core Data
        coreDataManager.getAllAlbums { [weak self] albums in
            guard let self = self else { return }
                completion(albums)
            self.albums = albums
                self.networkManager.getAlbums(albumName: albumName) { albums in
                    self.coreDataManager.save(albums: albums) {
                        completion(albums)
                    }
                }
        }
    }
}

//final class DataManager {
//    let coreDataManager = CoreDataManager.shared
//    let networkManager = NetworkManager()
//
//    func getAlbums(albumName: String, complition: @escaping ([Album]) -> Void) {
//        coreDataManager.getAllAlbums { albums in
//            complition(albums)
//                self.networkManager.getAlbums(albumName: albumName) { albums in
//                    self.coreDataManager.save(albums: albums) {
//                        complition(albums)
//                    }
//                }
//            }
//        }
//    }

