//
//  PhotosVC.swift
//  LifeArt
//
//  Created by Muhammad Imran on 16/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit

protocol ScrollingDelegate: class {
    func scrolling(_ scrollView: UIScrollView , collectionView : UICollectionView)
    
}

class PhotosVC: UIViewController {
    var arrayOfImage : [UIImage] = [#imageLiteral(resourceName: "1"),#imageLiteral(resourceName: "1"),#imageLiteral(resourceName: "1"),#imageLiteral(resourceName: "1"),#imageLiteral(resourceName: "1"),#imageLiteral(resourceName: "1"),#imageLiteral(resourceName: "1"),#imageLiteral(resourceName: "1"),#imageLiteral(resourceName: "1"),#imageLiteral(resourceName: "1")]
    let maxHeaderHeight: CGFloat = 450
    let minHeaderHeight: CGFloat = 20
    var previousScrollOffset: CGFloat = 0
    
    var delegate : ScrollingDelegate?
    @IBOutlet weak var collectionView : UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
    }

}

extension PhotosVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        cell.userImage.image  = arrayOfImage[indexPath.row]
        return cell
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let noOfCellsInRow = 2

        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

        return CGSize(width: size, height: size)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return  5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return  5
    }
}

extension PhotosVC {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //delegate!.scrolling(scrollView, collectionView: collectionView)
    }
}
