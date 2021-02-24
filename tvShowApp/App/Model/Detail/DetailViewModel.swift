//
//  DetailViewModel.swift
//  tvShowApp
//
//  Created by Walter Bladimir Rafael on 23/2/21.
//

import UIKit

class DetailViewModel {

    // Output
    var numberOfRows = 0
    
    private var show: Show!
    private var dataSource = [ImageAndLabelCollectionCellVM]()
    
    init(show: Show) {
        self.show = show
        prepareTableDataSource()
        configureOutput()
    }
    
    private func prepareTableDataSource() {
        show.cast?.forEach({
            dataSource.append(ImageAndLabelCollectionCellVM(dataModel: ImageAndLabelCollectionCellModel(name: $0.name ?? "", imageUrl: "\(Constants.WS.baseURLImages.rawValue)\($0.profile_path ?? "")")))
        })
    }
    
    private func configureOutput() {
        numberOfRows = dataSource.count
    }
    
    func cellViewModel(indexPath: IndexPath)->ImageAndLabelCollectionCellVM {
        let cellViewModel = dataSource[indexPath.row]
        return cellViewModel
    }
    
    func setAuthors() -> String {
        guard let aCreators = show.detail?.created_by else { return "" }
        guard aCreators.count > 0 else { return "" }
        var creators = "Created by:\n\n"
        aCreators.forEach({
            creators += "\($0.name ?? "")\n"
        })
        return "\(creators)"
    }
    
    func season() -> Season? {
        let s = show.detail?.seasons?.filter({ (s) -> Bool  in
            s.air_date != ""
        })
        return s?.last
    }
}

