//
//  TabBarController.swift
//  ItunseCoreData
//
//  Created by Рахим Габибли on 24.07.2024.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {

    var searchBar = UISearchBar()
    let networkManager = NetworkManager()
    let dataManager = DataManager()
    let coreDataManager = CoreDataManager.shared
    let searchHistoryViewController = SearchHistoryViewController()
    let viewController = ViewController()
    var albums = [Album]()
    var searchTexts = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViewControllers()
        setupSearchBar()

        coreDataManager.getAllAlbums { [weak self] albums in
            guard let self = self else { return }
            self.albums = albums
            DispatchQueue.main.async {
                self.viewController.albums = albums
                self.viewController.collectionView.reloadData()
            }
        }

        coreDataManager.getAllSearchText { [weak self] texts in
            guard let self = self else { return }
            self.searchTexts = texts
            DispatchQueue.main.async {
                self.searchHistoryViewController.searchHistory = texts
                self.searchHistoryViewController.tableView.reloadData()
            }
        }
    }

    private func setupSearchBar() {
        searchBar.placeholder = "Search"
        searchBar.delegate = self

        if let navController = viewControllers?.first as? UINavigationController {
            navController.navigationBar.topItem?.titleView = searchBar
        }
    }

    private func setupViewControllers() {
        let searchNavController = UINavigationController(rootViewController: viewController)
        searchNavController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 0)

        let historyNavController = UINavigationController(rootViewController: searchHistoryViewController)
        historyNavController.tabBarItem = UITabBarItem(title: "History", image: UIImage(systemName: "clock"), tag: 1)

        viewControllers = [searchNavController, historyNavController]

    }

    func performInitialSearch(with searchText: String) {
       searchBar.text = searchText
       searchBarSearchButtonClicked(searchBar)
   }
}

extension TabBarController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            return
        }

        print("AAA")
        dataManager.getAlbums(albumName: searchText) { [weak self] albums in

            self?.albums = albums
            print("BBB")
            self?.viewController.albums = albums
            self?.coreDataManager.update(text: searchText)

            DispatchQueue.main.async {
                self?.viewController.collectionView.reloadData()
            }
        }
    }
}
