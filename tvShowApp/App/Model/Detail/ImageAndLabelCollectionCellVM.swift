//
//  ImageAndLabelCollectionCellVM.swift
//  tvShowApp
//
//  Created by Walter Bladimir Rafael on 23/2/21.
//


import UIKit

struct ImageAndLabelCollectionCellModel {
    var name: String = ""
    var imageUrl: String = ""
}

class ImageAndLabelCollectionCellVM {
    
    private var dataModel: ImageAndLabelCollectionCellModel!
    
    // Output
    var imageURL: String!
    var text: String!
    
    init(dataModel: ImageAndLabelCollectionCellModel) {
        self.dataModel = dataModel
        configureOutput()
    }
    
    private func configureOutput() {
        imageURL = dataModel.imageUrl
        text = dataModel.name
    }
}

