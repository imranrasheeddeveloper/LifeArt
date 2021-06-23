//
//  OverlayView.swift
//  LifeArt
//
//  Created by Muhammad Imran on 07/04/2021.
//

import UIKit



class OverlayView: UIViewController  {
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    @IBOutlet weak var slideIdicator: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var delegate :  whoAreYouDelegate? = nil
    var arrSelectedIndex = [IndexPath]()
    var arrData : [String] = ["Figure" , "Portraits" , "Art Groups" , "Art Education" , "Photo Sets" , "Private Sitting" , "Online Figure" , "Online Clothed"]
    var selectData = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
        slideIdicator.roundCorners(.allCorners, radius: 10)
        collectionView.register(UINib(nibName: "ArtistCategories", bundle: nil), forCellWithReuseIdentifier: "ArtistCategories")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = true
        
    }

    override func viewWillDisappear(_ animated: Bool) {
   
        delegate?.whoAreYouData(categories: selectData)

    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
}

extension OverlayView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrData.count
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ArtistCategories = collectionView.dequeueReusableCell(withReuseIdentifier: "ArtistCategories", for: indexPath) as! ArtistCategories
        cell.categoriesLbl.text = arrData[indexPath.row]
        cell.categoriesLbl.font = UIFont.init(name: "Avenir", size: 13)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectData.count != 0{
            for (index, data) in selectData.enumerated() {
                if arrData[indexPath.row] == data{
                    arrData.remove(at: index)
                }
                else{
                    selectData.append(arrData[indexPath.row])
                    
                }
            }
        }
        else{
            selectData.append(arrData[indexPath.row])
        }
        
    
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 100, height: 40)
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10

    }
}


