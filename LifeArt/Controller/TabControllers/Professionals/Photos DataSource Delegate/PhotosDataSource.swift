//
//  PhotosDataSource.swift
//  LifeArt
//
//  Created by Muhammad Imran on 19/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit
import SDWebImage
class PhotosDataSource: NSObject , UICollectionViewDataSource{
    var arrayOfImage = [String]()
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        cell.userImage.sd_setImage(with:URL(string:arrayOfImage[indexPath.row]),
                                   placeholderImage: UIImage(named: "placeholder.png"))
        return cell
    }
    

}
