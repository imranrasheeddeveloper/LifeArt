//
//  SgesstedHeaderView.swift
//  LifeArt
//
//  Created by Muhammad Imran on 09/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import Foundation
import UIKit

class SugesstedHeaderView: UICollectionReusableView {
    static let reuseIdentifierHeader = "SugesstedHeaderView"
    let label = UILabel()
    var selectButton =  UIButton()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = "Trending"
        label.textColor = .white
        
        selectButton.frame = CGRect(x: frame.size.width - 85, y: frame.size.height - 28, width: 77, height: 26)
        selectButton.setTitle("View All", for: .normal)
        selectButton.titleLabel?.textColor =  .white
        selectButton.contentHorizontalAlignment = .right;
        selectButton.addTarget(self, action: #selector(viewAll), for: .touchUpInside)
        addSubview(label)
        
        addSubview(selectButton)
       
      
    }
    
    
    @objc func viewAll(_ sender: UIButton){
        print(sender.tag)
        //parentViewController?.pushToRoot(from: .main, identifier: .)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
