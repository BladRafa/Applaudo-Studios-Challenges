//
//  PaginationCellVM.swift
//  tvShowApp
//
//  Created by Walter Bladimir Rafael on 23/2/21.
//

import UIKit

class PaginationCellVM {

    // Output
    var numberOfPages = 0
    var title = ""
    
    // Datasource
    private var dataSource = [Show]()
    
    // Events
    var showSelected: (Show)->()?
    
    init(data: [Show],showSelected: @escaping (Show)->()) {
        dataSource = data
        self.showSelected = showSelected
        configureOutput()
    }
    
    private func configureOutput() {
        numberOfPages = dataSource.count
        title = "TV Shows: \(AppData.sharedData.showTypeSelected.displayText())"
    }
    
    func viewModelForShowView(position: Int)->ShowViewVM {
        let show = dataSource[position]
        let showViewVM = ShowViewVM(show: show)
        showViewVM.showSelected = { [weak self] in
            self?.showSelected(show)
        }
        return showViewVM
    }
}
