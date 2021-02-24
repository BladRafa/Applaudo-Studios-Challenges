//
//  Cells.swift
//  tvShowApp
//
//  Created by Walter Bladimir Rafael on 23/2/21.
//

import UIKit

open class ReusableTableViewCell: UITableViewCell {
    
    // Reuse Identifier String
    public class var reuseIdentifier: String {
        return "\(self.self)"
    }
    
    // Registers the Nib with the provided table
    public static func registerWithTable(_ table: UITableView) {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: self.reuseIdentifier , bundle: bundle)
        table.register(nib, forCellReuseIdentifier: self.reuseIdentifier)
    }
}

open class ReusableCollectionViewCell: UICollectionViewCell {
    
    // Reuse Identifier String
    public class var reuseIdentifier: String {
        return "\(self.self)"
    }
    
    // Registers the Nib with the provided table
    public static func registerWithCollectionView(_ collectionView: UICollectionView) {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: self.reuseIdentifier , bundle: bundle)
        collectionView.register(nib, forCellWithReuseIdentifier: self.reuseIdentifier)
    }
}

