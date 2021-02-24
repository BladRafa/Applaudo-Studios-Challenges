//
//  CollectionViewController.swift
//  tvShowApp
//
//  Created by Walter Bladimir Rafael on 23/2/21.
//

import UIKit


class CollectionViewController: UICollectionViewController {
    
    
    //
    let datasource = ["hola1","hola2","hola3",
                       "hola4","hola5","hola6",
                       "hola7","hola8","hola9","hola10"]
    let arrayImgenShow : [UIImage] = [
        UIImage(named:"Image")!, UIImage(named:"Image")!, UIImage(named:"Image")!,
        UIImage(named:"Image")!, UIImage(named:"Image")!, UIImage(named:"Image")!,
        UIImage(named:"Image")!, UIImage(named:"Image")!, UIImage(named:"Image")!,
        UIImage(named:"Image")!,
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
 
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         var cell =  CollectionViewCell()
        
        if let name = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CollectionViewCell{
            name.configureTvShow(with: datasource[indexPath.row],image: arrayImgenShow[indexPath.row])
            cell = name
        }
        return cell
    }
  
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selecciono: \(datasource[indexPath.row])")
    }
    
    

}
