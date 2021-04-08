//
//  SuggestedParentCell.swift
//  LifeArt
//
//  Created by Muhammad Imran on 09/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit

class SuggestedParentCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "SuggestedCell", bundle: nil), forCellWithReuseIdentifier: "SuggestedCell")
        collectionView.register(SugesstedHeaderView.self, forSupplementaryViewOfKind: "categoryHeaderId", withReuseIdentifier: "headerId")
        
    
    }
    
}

//MARK:- Delegate DataSource
extension SuggestedParentCell :  UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestedCell", for: indexPath)
            return cell
     
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 200, height: 250)
        }
    
     func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionFooter) {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath)
            // Customize footerView here
            return footerView
        } else if (kind == UICollectionView.elementKindSectionHeader) {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath)
            // Customize headerView here
            return headerView
        }
        fatalError()
    }
    
}
