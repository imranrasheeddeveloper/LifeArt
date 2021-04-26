//
//  CommentsVC.swift
//  LifeArt
//
//  Created by Muhammad Imran on 23/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit

class CommentsVC: UIViewController {
    @IBOutlet weak var tableView : UITableView!
    
    let array = ["Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero's De Finibus Bonorum et Malorum for use in a type specimen book", "this is the vire"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource  = self
        tableView.delegate = self
        tableView.separatorStyle  = .none
        tableView.register(UINib(nibName: "CommentsCell", bundle: nil), forCellReuseIdentifier: "CommentsCell")
    }
    
}

extension CommentsVC : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsCell", for: indexPath) as! CommentsCell
        cell.commentText.text = array[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120 + cellSize(forWidth: self.view.frame.size.width, text: array[indexPath.row]).height
    }
    func cellSize(forWidth width: CGFloat, text : String) -> CGSize {
        let measurmentLabel = UILabel()
        measurmentLabel.text = text
        measurmentLabel.numberOfLines = 0
        measurmentLabel.lineBreakMode = .byWordWrapping
        measurmentLabel.translatesAutoresizingMaskIntoConstraints = false
        measurmentLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        return measurmentLabel.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
    
    func calculateHeight(inString:String) -> CGFloat
    {
        let messageString = inString
        let attributes : [NSAttributedString.Key : Any] = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15.0)]

        let attributedString : NSAttributedString = NSAttributedString(string: messageString, attributes: attributes)

        let rect : CGRect = attributedString.boundingRect(with: CGSize(width: 222.0, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)

        let requredSize:CGRect = rect
        return requredSize.height
    }
}
