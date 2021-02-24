//
//  CollectionViewCell.swift
//  tvShowApp
//
//  Created by Walter Bladimir Rafael on 22/2/21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tvShowLabel: UILabel!
    @IBOutlet weak var tvShowImage: UIImageView!
    
    func configureTvShow(with name: String,image:UIImage) {
        tvShowLabel.text = name
        tvShowImage.image = image
    }
}
