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
    var searchTexts = [String]()

    func getAlbums(albumName: String, completion: @escaping ([Album]) -> Void) {
        coreDataManager.getAllAlbums { [weak self] albums in
            guard let self = self else { return }
//            completion(albums)
            self.albums = albums
            self.networkManager.getAlbums(albumName: albumName) { albums in
                self.coreDataManager.save(albums: albums) {
                    completion(albums)
                }
            }
        }
    }

    func getSearchTexts(searchText: String) {
        coreDataManager.getAllSearchText { [weak self] searchTexts in
            self?.searchTexts.append(searchText)

            guard let searchTexts = self?.searchTexts else {
                return
            }

            self?.coreDataManager.save(texts: searchTexts, completion: {})

        }
    }
}
