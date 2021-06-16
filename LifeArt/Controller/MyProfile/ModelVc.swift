//
//  ModelVc.swift
//  LifeArt
//
//  Created by Muhammad Imran on 14/06/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit

class ModelVc: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
       // collectionView.dataSource  = self
        collectionView.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier:  "PhotoCell")
    }
    


}
extension ModelVc:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////        let cell = collectionView.dequeueConfiguredReusableSupplementary(using: "PhotoCell", for: indexPath) as! PhotoCell
//        //return cell
//    }
    
    
    
    
}
