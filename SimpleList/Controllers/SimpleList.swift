//
//  ViewController.swift
//  SimpleList
//
//  Created by shimanopower on 9/18/20.
//  Copyright © 2020 shimanopower. All rights reserved.
//

import UIKit

class SimpleList: UITableViewController, Storyboarded {
    weak var coordinator: MainCoordinator?
    private var items = [ItemData]()
//    private var filteredItems = [ItemData]()
    private var searchController = UISearchController(searchResultsController: nil)
    private lazy var dataSource = makeDatasource()
    
    enum Section {
        case main
    }
    
    typealias DataSource = UITableViewDiffableDataSource<Section, ItemData>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, ItemData>

    override func viewDidLoad() {
        super.viewDidLoad()
        
        assert(coordinator != nil, "You msut implement a coordinator")
        title = "Items"
        fetchItemData()
        configureSearchController()
        applySnapshot(animatingDifferences: false)
    }
    
    func fetchItemData() {
        ItemFetchingService.fetchItems { [weak self] (itemData, error) in
            guard let self = self else { return }
            guard let itemData = itemData else { return }
            let sorted = itemData.sorted(by: <)
            self.items = sorted.filter { $0.name != "" }
        }
    }
    
    func makeDatasource() -> DataSource {
        let dataSource = DataSource(tableView: tableView, cellProvider: {
            (tableView, indexPath, item) -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as? ItemTableViewCell else { fatalError() }
            var sectionName: String
            if let section = item.sectionIdentifier {
                sectionName = "\(section)"
            } else {
                sectionName = "No Section!"
            }
            cell.titleLabel.text = "Section: \(sectionName) Name: \(item.name)"
            let idInt = item.id ?? 0
            let idString = String(idInt)
            cell.subtitleLabel.text = "Id: \(idString)"
            return cell
        })
       return dataSource
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapShot = Snapshot()
        snapShot.appendSections([.main])
        snapShot.appendItems(items)
        dataSource.apply(snapShot, animatingDifferences: animatingDifferences)
    }
}

extension SimpleList: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        items = filteredItems(for: searchController.searchBar.text)
        applySnapshot()
    }
    
    func filteredItems(for query: String?) -> [ItemData] {
        guard let search = query, !search.isEmpty else { return items }
        let filtered = items
        return filtered.filter {
            return $0.name.lowercased().contains(search.lowercased())
        }
    }
    
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Items"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

