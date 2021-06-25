//
//  CreatePostVC.swift
//  LifeArt
//
//  Created by Muhammad Imran on 17/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit
import Firebase
import MaterialComponents.MDCOutlinedTextField

class CreatePostVC: UIViewController {
    
    
    //MARK:- Outlets
    @IBOutlet weak var postTitleTF: MDCOutlinedTextField!
    @IBOutlet weak var descriptionTF : MDCOutlinedTextField!
    @IBOutlet weak var NavigationBarView : UIView!
    @IBOutlet weak var bottomView : UIView!
    @IBOutlet weak var selectedImage : UIImageView!
    @IBOutlet weak var meduimTF: MDCOutlinedTextField!
    @IBOutlet weak var sizeTF: MDCOutlinedTextField!
    
    
    
    
    //MARK:- variable declaration
    
    var accountType : AccountType = .Artist
    var user : User?
    
    
    //MARK:- lifeCyscles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBar()
        hideKeyboard()
        NavigationBarView.dropShadow()
        NavigationBarView.roundCorners(corners: .layerMinXMaxYCorner, radius: 30)
        bottomView.dropShadow()
        checkUserType()
        setupTextfileds()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        fetchUser()
        
    }
    func setupTextfileds() {
        postTitleTF.label.text = "Title"
        meduimTF.label.text = "Meduim"
        sizeTF.label.text  = "Size"
        descriptionTF.label.text = "Description"
        
        descriptionTF.sizeToFit()
        postTitleTF.sizeToFit()
        meduimTF.sizeToFit()
        sizeTF.sizeToFit()
        
        postTitleTF.containerRadius = 10
        sizeTF.containerRadius  = 10
        postTitleTF.containerRadius = 10
        descriptionTF.containerRadius = 10
        
       // descriptionTF.verticalDensity = 80
        postTitleTF.verticalDensity = 40
        meduimTF.verticalDensity = 40
        sizeTF.verticalDensity = 40
    }
    
    //MARK:- Helper Functions
    
    func checkUserType() {
     REF_Artists.child(Auth.auth().currentUser!.uid).observe(.value) { [self] (snapshot) in
            if snapshot.exists() {
                accountType = .Artist
            }
            else{
                accountType = .Model
            }
        }
    }
    
    @IBAction func addPost(_ sender: UIButton) {
        let date = currentDate()
        let time = currentTime()
        apiCalling(date :  date , time : time)
    }
    @IBAction func PhotosOpen(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true)
    }
    @IBAction func cameraOpen(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        picker.allowsEditing = false
        present(picker, animated: true)
    }
    
    //MARK:- API Calling
    
    func apiCalling(date :  String , time : String) {
        if descriptionTF.text != "" {
            if postTitleTF.text != ""{
                if meduimTF.text != ""{
                    if sizeTF.text != ""{
                        let post = CreatePost(date: date, desc: descriptionTF.text ?? "test", image: selectedImage.image ?? #imageLiteral(resourceName: "art2"), medium: meduimTF.text!, size: sizeTF.text!, time: time, title: postTitleTF.text ?? "Test" , user: Auth.auth().currentUser!.uid)
                        PostService.shared.creatPost(account: accountType , post: post) { [self] (eror, ref) -> (Void) in
                            if eror == nil{
                                self.showToast(message: "Post Uploaded", seconds: 1.0)
                                
                                guard let fullName = user?.firstname else { return }
                                PushNotificationSender.shared.sendPushNotification(to: "" , title: fullName  , body: descriptionTF.text!)
                                postTitleTF.text = ""
                                descriptionTF.text = ""
                                meduimTF.text = ""
                                sizeTF.text = ""
                                selectedImage.image = nil
                                
                            }
                            else{
                                print(eror?.localizedDescription as Any)
                            }
                        }
                    }
                }
            }
        }
        else{
            self.presentAlert(withTitle: "Error", message: "Fill the TextFields")
        }
    }
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        UserService.shared.checkArtistExist(uid: uid) { (result) in
            if result{
                UserService.shared.fetchUser(uid: uid) { [self] (user) in
                    self.user = user
                }
            }
            else{
                UserService.shared.fetchMyModelUser(uid: uid) { [self] (user) in
                    self.user = user
                }
            }
        }
    }


    @IBAction func backbtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension CreatePostVC :UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        selectedImage.image = originalImage
    }
}


