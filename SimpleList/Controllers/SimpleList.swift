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
    var items = [ItemData]()
    var searchController = UISearchController(searchResultsController: nil)
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, ItemData>
    var dataSource: DataSource!
    
    var sections: [Section] = Section.sections
    
// Mark: Subclassing UITableViewDiffableDataSource
// Subclassling UITableViewDiffableDataSource was the easiest way I've found to use diffable datssource to provide titles to sections. This is one Apple's own implementations shown at WWDC19 Advances in Datasources talk
    
    class DataSource: UITableViewDiffableDataSource<Section, ItemData> {
        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            let sectionKind = Section.sections
            return sectionKind[section].section.sectionFormatted
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        assert(coordinator != nil, "You msut implement a coordinator")
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Items"
        fetchItemData()
        configureSearchController()
    }
    
    func fetchItemData() {
        ItemFetchingService.fetchItems { [weak self] (itemData, error) in
            guard let self = self else { return }
            guard let itemData = itemData else { return }
            let sorted = itemData.sorted(by: <)
            self.items = sorted.filter { $0.name != "" }
            self.createSections()
            self.finishedFetching()
        }
    }
    
    func finishedFetching() {
        makeDatasource()
        applySnapshot(animatingDifferences: false)
    }
    
    // Mark: Here our sections are created by reading section identifier from ItemData and using it instantiate Sections and add them into our sections array
    
    func createSections() {
        var currentSection = ""
        var currentItems = [ItemData]()
           
        for item in self.items.sorted(by: <) {
            let sectionInt = item.sectionIdentifier ?? 0
            let sectionName = String(sectionInt)
            if currentSection == "" { currentSection = sectionName }
            if currentSection == sectionName {
                currentItems.append(item)
            } else {
                Section.sections.append(Section(title: currentSection, items: currentItems))
                currentSection = sectionName
                currentItems.removeAll()
                currentItems.append(item)
            }
        }
        
        Section.sections.append(Section(title: currentSection, items: currentItems))
        self.sections = Section.sections
    }
    
    func makeDatasource() {
        self.dataSource = DataSource(tableView: tableView, cellProvider: {
            (tableView, indexPath, item) -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as? ItemTableViewCell else { fatalError() }
            cell.nameLabel = item.name
            cell.idLabel = item.id
            return cell
        })
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapShot = Snapshot()
        snapShot.appendSections(sections)
        self.sections.forEach { section in
            snapShot.appendItems(section.items, toSection: section)
        }
        
        dataSource.apply(snapShot, animatingDifferences: animatingDifferences)
    }
}

// MarK: Search / Filtering methods

extension SimpleList: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        sections = filteredSections(for: searchController.searchBar.text)
        applySnapshot()
    }
    
    func filteredSections(for query: String?) -> [Section] {
        let sections = Section.sections
        guard let search = query, !search.isEmpty else { return sections }
        
        var filtereSections = [Section]()
        
        for section in sections {
            let filteredItems = section.filterItems(search)
            let newSection = Section(title: section.section, items: filteredItems)
            filtereSections.append(newSection)
        }
        
        return filtereSections
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search by ID"
        navigationItem.searchController = searchController
        searchController.searchBar.keyboardType = .numberPad
        definesPresentationContext = true
    }
}

