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
    var arrayofModel = [UserModel]()
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource  = self
        collectionView.register(UINib(nibName: "SuggestedCell", bundle: nil), forCellWithReuseIdentifier:  "SuggestedCell")

        UserService.shared.fetchModels { [self] (user) in
                arrayofModel = user
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
        }
    }
    
}

//MARK:- UICollectionView Delegate & DataSource
extension ModelVc :  UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return arrayofModel.count
      
    }
    
    //TODO:- set Collection View
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestedCell", for: indexPath) as! SuggestedCell
            cell.profileImage.sd_setImage(with:URL(string:arrayofModel[indexPath.row].image),
                                          placeholderImage: UIImage(named: "placeholder.png"))
            cell.nameLbl.text = "\(arrayofModel[indexPath.row].firstname) \(arrayofModel[indexPath.row].lastname)"
            
            return cell
     
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        GlobaluserID = arrayofModel[indexPath.row].user
        self.parent?.pushToRoot(from: .Home, identifier: .ProfessionalProfileVC)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        cell.alpha = 0
        UIView.animate(withDuration: 0.8) {
            cell.alpha = 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let noOfCellsInRow = 2

        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

        return CGSize(width: size, height: 300)
    }
    
    
}
