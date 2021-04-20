//
//  MyProfileVC.swift
//  LifeArt
//
//  Created by Muhammad Imran on 20/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit


class MyProfileVC: UIViewController, UICollectionViewDelegate {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var followAction: UIButton!
    @IBOutlet weak var heightConstrains: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var topConstrainsOfHeader: NSLayoutConstraint!
    
    var selectedIndex = 0
    let photosDataSource = PhotosDataSource()
    let photoDelegate = PhotosDelegate()
    let tableDataSource = UserPostDataSource()
    let maxHeaderHeight: CGFloat = 410
    let minHeaderHeight: CGFloat = 0
    var previousScrollOffset: CGFloat = 0
   
    private let collectionViewLayout: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        cv.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
        return cv
    }()
    
    
    private let tableviewLayout : UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = UIColor.white
        table.register(UINib(nibName: "ProfilePostCell", bundle: nil), forCellReuseIdentifier: "ProfilePostCell")
        return table
    }()
    
    override func viewDidLoad() {
        setStatusBar()
       
        hideKeyboard()
        if selectedIndex == 0{
            self.contentView.addSubview(tableviewLayout)
            tableviewLayout.delegate = self
            tableviewLayout.dataSource = tableDataSource
            setupConstrainsofTableView()
        }
        else{
            setupConstrainsofCollectionView()
            self.contentView.addSubview(collectionViewLayout)
            collectionViewLayout.dataSource = photosDataSource
            collectionViewLayout.delegate = self
        }
    
        
    }
    
    
    func setupConstrainsofCollectionView() {
        self.collectionViewLayout.anchor(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, bottom: self.contentView.bottomAnchor, right: self.contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
    func setupConstrainsofTableView() {
        self.tableviewLayout.anchor(top: self.contentView.topAnchor, left: self.contentView.leftAnchor, bottom: self.contentView.bottomAnchor, right: self.contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
    
    
    @IBAction func popViewController(_ sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func followAction(_ sender: UIButton) {
        self.PaymentAlert()
    }
    @IBAction func ValueChanged(_ sender: SWSegmentedControl) {
        
        if sender.selectedSegmentIndex == 0{
            selectedIndex = 0
            self.collectionViewLayout.removeFromSuperview()
            self.contentView.addSubview(tableviewLayout)
            setupConstrainsofTableView()
            tableviewLayout.delegate = self
            tableviewLayout.dataSource = tableDataSource
        
            setupConstrainsofTableView()
            DispatchQueue.main.async {
                self.tableviewLayout.reloadData()
            }
        }
        else if sender.selectedSegmentIndex == 1 {
            selectedIndex = 1
            tableviewLayout.removeFromSuperview()
            self.contentView.addSubview(collectionViewLayout)
            setupConstrainsofCollectionView()
            collectionViewLayout.dataSource = photosDataSource
            collectionViewLayout.delegate = self
            DispatchQueue.main.async {
                self.collectionViewLayout.reloadData()
            }
        }
    }
    
 
}


extension MyProfileVC {
    func canAnimateHeader (_ scrollView: UIScrollView) -> Bool {
        let scrollViewMaxHeight = scrollView.frame.height + self.heightConstrains.constant - minHeaderHeight
        return scrollView.contentSize.height > scrollViewMaxHeight
    }
    func setScrollPosition() {
        if selectedIndex == 0{
            self.tableviewLayout.contentOffset = CGPoint(x:0, y: 0)
            
        }
       else if selectedIndex == 1{
        self.collectionViewLayout.contentOffset = CGPoint(x:0, y: 0)
        }
    }
}
extension MyProfileVC : UICollectionViewDelegateFlowLayout{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        let scrollDiff = (scrollView.contentOffset.y - previousScrollOffset)
        let isScrollingDown = scrollDiff > 0
        let isScrollingUp = scrollDiff < 0
        if canAnimateHeader(scrollView) {
            var newHeight = heightConstrains.constant
            if isScrollingDown {
                newHeight = max(minHeaderHeight, heightConstrains.constant - abs(scrollDiff))
            } else if isScrollingUp {
                newHeight = min(maxHeaderHeight, heightConstrains.constant + abs(scrollDiff))
               // headerView.fadeIn()
            }
            if newHeight != heightConstrains.constant {
                heightConstrains.constant = newHeight

                setScrollPosition()
                previousScrollOffset = scrollView.contentOffset.y
            }
//            if heightConstrains.constant <= 20 {
//                headerView.fadeOut()
//            }
        }
        
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

//MARK:- TabelView delegate
extension MyProfileVC :  UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
}

