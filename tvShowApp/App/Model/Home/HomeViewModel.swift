//
//  HomeViewModel.swift
//  tvShowApp
//
//  Created by Walter Bladimir Rafael on 23/2/21.
//

import UIKit

// Enum to distinguish different home cell types
enum HomeTableCellType {
    case pagingCell(model: PaginationCellVM)
}

class HomeViewModel {
    
    // Data source for the home page table view.
    private var tableDataSource: [HomeTableCellType] = [HomeTableCellType]()
    
    // MARK: Input
    var viewDidLoad: ()->() = {}
    
    // MARK: Events
    // Callback to pass the selected show
    var showSelected: (Show)->() = { _ in }
    // Callback to reload the table
    var reloadTable: ()->() = { }
    
    // MARK: Output
    var numberOfRows = 0
    
    init() {
        viewDidLoad = { [weak self] in
            self?.getAppData(completion: {
                self?.prepareTableDataSource()
                self?.reloadTable()
            })
        }
    }
    
    // Method call to inform the view model to refresh the data
    func refreshScreen() {
        tableDataSource.removeAll()
        guard Utilities.hasInternet() else {
            AppData.sharedData.getShows()
            prepareTableDataSource()
            reloadTable()
            return
        }
        self.getAppData(completion: { [weak self] in
            self?.prepareTableDataSource()
            self?.reloadTable()
        })
    }
    
    private func getAppData(completion: @escaping ()->()) {
        TVShowsWS().getTVShows() { (showList, error) in
            // Reset the app data and populate with new data
            AppData.sharedData.resetData()
            AppData.sharedData.allShows = showList ?? [Show]()
            completion()
        }
    }
    
    // Prepare the tableDataSource
    private func prepareTableDataSource() {
        tableDataSource.append(cellTypeForPagingCell())
        numberOfRows = tableDataSource.count
    }
    
    // Provides a pagination cell type for each show type
    private func cellTypeForPagingCell()->HomeTableCellType {
        let showSelected: (Show)->() = { [weak self] show in
            // Go to show detail
            self?.showSelected(show)
        }
        return HomeTableCellType.pagingCell(model: PaginationCellVM(data: AppData.sharedData.allShows, showSelected: showSelected))
    }
    
    // Provides the view with appropriate cell type corresponding to an index.
    func cellType(forIndex indexPath: IndexPath)->HomeTableCellType {
        return tableDataSource[indexPath.row]
    }
}
