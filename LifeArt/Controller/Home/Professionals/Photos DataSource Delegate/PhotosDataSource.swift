//
//  PhotosDataSource.swift
//  LifeArt
//
//  Created by Muhammad Imran on 19/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit

class PhotosDataSource: NSObject , UICollectionViewDataSource{
    var arrayOfImage : [UIImage] = [#imageLiteral(resourceName: "1"),#imageLiteral(resourceName: "1"),#imageLiteral(resourceName: "1"),#imageLiteral(resourceName: "1"),#imageLiteral(resourceName: "1"),#imageLiteral(resourceName: "1"),#imageLiteral(resourceName: "1"),#imageLiteral(resourceName: "1"),#imageLiteral(resourceName: "1"),#imageLiteral(resourceName: "1")]
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        cell.userImage.image  = arrayOfImage[indexPath.row]
        return cell
    }
    

}
