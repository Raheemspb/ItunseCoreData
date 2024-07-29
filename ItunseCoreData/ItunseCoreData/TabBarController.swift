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
    let searchHistoryViewController = SearchHistoryViewController()
    let viewController = ViewController()
    var albums = [Album]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViewControllers()
        setupSearchBar()
//        if let searchTexts = networkManager.getSearchTextFromKeychain() {
//            performInitialSearch(with: searchTexts.last!)
//        }
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

        dataManager.getAlbums(albumName: searchText) { [weak self] albums in

            self?.albums = albums

            DispatchQueue.main.async {
                self?.viewController.albums = albums
                self?.viewController.collectionView.reloadData()
                self?.searchHistoryViewController.tableView.reloadData()
            }
        }

//        networkManager.getAlbums(albumName: searchText) { [weak self] albums in
//
//            self?.albums = albums
//
//            DispatchQueue.main.async {
//                self?.viewController.albums = albums
//                self?.viewController.collectionView.reloadData()
//                self?.searchHistoryViewController.tableView.reloadData()
//            }
//        }

        //        searchBar.resignFirstResponder()
    }
}
