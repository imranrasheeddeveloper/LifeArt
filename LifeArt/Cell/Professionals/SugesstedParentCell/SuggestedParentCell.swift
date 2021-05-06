//
//  SuggestedParentCell.swift
//  LifeArt
//
//  Created by Muhammad Imran on 09/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit
import SDWebImage
class SuggestedParentCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var cellNumber : Int?
    var arrayofModel = [User]()
    var arrayofArtisr = [User]()
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "SuggestedCell", bundle: nil), forCellWithReuseIdentifier: "SuggestedCell")
        collectionView.register(UINib(nibName: "SuggestedArtistCell", bundle: nil), forCellWithReuseIdentifier: "SuggestedArtistCell")
        
        UserService.shared.fetchArtist { [self] (user) in
            arrayofArtisr = user
            UserService.shared.fetchModels { (user) in
                arrayofModel = user
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
}

//MARK:- UICollectionView Delegate & DataSource
extension SuggestedParentCell :  UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if cellNumber == 0 {
            return arrayofModel.count
        }
        else {
            return  arrayofArtisr.count
        }
    }
    
    //TODO:- set Collection View
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if cellNumber == 0 {
            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestedCell", for: indexPath) as! SuggestedCell
            cell.profileImage.sd_setImage(with:URL(string:arrayofModel[indexPath.row].image),
                                          placeholderImage: UIImage(named: "placeholder.png"))
            cell.nameLbl.text = "\(arrayofModel[indexPath.row].firstname) \(arrayofModel[indexPath.row].lastname)"
            
            return cell
            
        }
        else{
            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestedArtistCell", for: indexPath) as! SuggestedArtistCell
            cell.profileImage.sd_setImage(with:URL(string:arrayofArtisr[indexPath.row].image),
                                          placeholderImage: UIImage(named: "placeholder.png"))
            cell.nameLbl.text = "\(arrayofArtisr[indexPath.row].firstname) \(arrayofArtisr[indexPath.row].lastname)"
            cell.dicLbl.text = arrayofArtisr[indexPath.row].bio
            return cell
        }
        
     
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 300)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.parentViewController?.pushToRoot(from: .Home, identifier: .ProfessionalProfileVC)
    }
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        cell.alpha = 0
        UIView.animate(withDuration: 0.8) {
            cell.alpha = 1
        }
    }
}
