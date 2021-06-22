//
//  ModelVc.swift
//  LifeArt
//
//  Created by Muhammad Imran on 14/06/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit

class ModelVc: UIViewController  {

    //MARK:-OUTLETS
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchTF: DesignableUITextField!

    //MARK:-VAriables
    var arrayofModel = [UserModel]()
   // var realArrayofModel = [UserModel]()
    var isSearch = false
    var fillterArray = [UserModel]()
    let searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()

        self.searchController.searchBar.autocapitalizationType = UITextAutocapitalizationType.none
//               self.navigationItem.searchController = self.searchController
//              //if this is set to true, the search bar hides when you scroll.
//               self.navigationItem.hidesSearchBarWhenScrolling = false
//               //this is so I'm told of changes to what's typed
//               self.searchController.searchResultsUpdater = self
//               self.searchController.searchBar.delegate = self

           
        
        collectionView.delegate = self
        collectionView.dataSource  = self
        collectionView.register(UINib(nibName: "SuggestedCell", bundle: nil), forCellWithReuseIdentifier:  "SuggestedCell")

        UserService.shared.fetchModels { [self] (user) in
                arrayofModel = user
           // realArrayofModel = arrayofModel

                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
        }
    }
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        arrayofModel.removeAll()
//        for item in realArrayofModel {
//            if item.firstname.contains(searchBar.text!){
//                arrayofModel.append(item)
//            }
//        }
//        if (searchBar.text!.isEmpty){
//           arrayofModel = realArrayofModel
//        }
//        self.collectionView.reloadData()
//    }
    @IBAction func searchTFChange(_ sender: UITextField) {
        isSearch = true
        fillterArray.removeAll()
     
        fillterArray = arrayofModel.filter({
            if  $0.firstname.contains(sender.text!) {
                self.collectionView.reloadData()
                return true
            }
            else{
               return false
            }
        
        })
        if sender.text?.count == 0{
            isSearch = false
           // self.arrayofModel = self.fillterArray
            self.collectionView.reloadData()
        }
       // self.collectionView.reloadData()
    }
}

//MARK:- UICollectionView Delegate & DataSource
extension ModelVc :  UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout,UISearchBarDelegate,UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearch {
            return fillterArray.count
        }
        else{
            return arrayofModel.count
        }
      
    }
    
    //TODO:- set Collection View
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestedCell", for: indexPath) as! SuggestedCell
            cell.profileImage.sd_setImage(with:URL(string:arrayofModel[indexPath.row].image),
                                          placeholderImage: UIImage(named: "placeholder.png"))
            cell.profileImage.sd_imageIndicator?.startAnimatingIndicator()

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
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let searchView: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader
//, withReuseIdentifier: "SearchBar", for: indexPath)
//
//        return searchView
//    }
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
  

}
