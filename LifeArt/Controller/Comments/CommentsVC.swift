//
//  CommentsVC.swift
//  LifeArt
//
//  Created by Muhammad Imran on 23/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit

class CommentsVC: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var commentsView : UIView!
    @IBOutlet weak var commentsTF: UITextField!
    
    //MARK:- Variables
    var users = [User]()
    var array = [Comments]()
    var exist : Bool = false
    var uIDArray = [String]()
    
    //MARK:- LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        commentsView.dropShadow()
        tableView.dataSource  = self
        tableView.delegate = self
        tableView.separatorStyle  = .none
        tableView.register(UINib(nibName: "CommentsCell", bundle: nil), forCellReuseIdentifier: "CommentsCell")
        fetchComments()
        commentsView.layer.borderWidth = 0.5
    }
    
    //MARK:- Helper functions
    func fetchComments() {
        array.removeAll()
        CommentsService.shared.fetchCommentstServices { [self] (comments) in
            self.array.append(contentsOf: comments)
            for (index , _) in array.enumerated(){
                self.uIDArray.append(array[index].commentsData.from)
            }
            getUser()
        }
    }
    
    //MARK:- Actions
    @IBAction func sendComment(_ sender: UIButton) {
        if commentsTF.text != ""{
            apiCalling()
        }
        
    }
    
    
    //MARK:- APIs
    func apiCalling() {
        let comment = CreateComment(comment: commentsTF.text!, date: currentDate(), time: Int(currentTimeInInteger())!)
        CommentsService.shared.creatComment(key: commentsTag, comment: comment) { [self] (error, ref) -> (Void) in
            commentsTF.text = ""
            fetchComments()
        }
    }
    
    func checkArtistExist(uid: String, completion: @escaping(Bool) -> Void) {
        REF_Artists.child(uid).observe(.value) {(snapshot) in
            print(uid)
            if snapshot.exists() {
                completion(true)
            }
            else{
                completion(true)
            }
        }
    }
    
    func getUser(){
        for userId in uIDArray{
            
            checkArtistExist(uid: userId) { (result) in
                if result{
                    UserService.shared.fetchArtistUser(uid: userId) { (user) in
                        self.users.append(user)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
                else{
                    UserService.shared.fetchModelsUser(uid: userId) { (user) in
                        self.users.append(user)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
            
        }
    }
}

extension CommentsVC : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsCell", for: indexPath) as! CommentsCell
        cell.commentText.text = array[indexPath.row].commentsData.comment
        cell.userImage.sd_setImage(with:URL(string:users[indexPath.row].image),
                                   placeholderImage: UIImage(named: "placeholder.png"))
        cell.fullname.text = "\(users[indexPath.row].firstname) \(users[indexPath.row].lastname)"
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120 + cellSize(forWidth: self.view.frame.size.width, text: array[indexPath.row].commentsData.comment).height
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
