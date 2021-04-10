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
    let titleLabel = UILabel()
        let viewAllButton = UIButton()
        
        // Callback closure to handle info button tap
        var infoButtonDidTappedCallback: (() -> Void)?

        override init(frame: CGRect) {
            super.init(frame: frame)
            configure()
        }
        
        required init?(coder: NSCoder) {
            fatalError("Not implemented")
        }
    func configure() {
            
            // Add a stack view to section container
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.distribution = .fill
            addSubview(stackView)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                stackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
                stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
                stackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            ])

            // Setup label and add to stack view
            titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
            stackView.addArrangedSubview(titleLabel)

            // Set button image
           viewAllButton.setTitle("View all", for: .normal)
        viewAllButton.titleLabel?.textColor = .black
            
            // Set button action
          viewAllButton.addAction(UIAction(handler: { [unowned self] (_) in
                // Trigger callback when button tapped
                self.infoButtonDidTappedCallback?()
            }), for: .touchUpInside)
            
            // Add button to stack view
            stackView.addArrangedSubview(viewAllButton)
            
        }
}
