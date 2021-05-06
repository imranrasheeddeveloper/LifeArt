//
//  CreatePostVC.swift
//  LifeArt
//
//  Created by Muhammad Imran on 17/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import UIKit
import Firebase
class CreatePostVC: UIViewController {
    @IBOutlet weak var postTitleTF: UITextField!
    @IBOutlet weak var textView : UITextView!
    @IBOutlet weak var NavigationBarView : UIView!
    @IBOutlet weak var bottomView : UIView!
    @IBOutlet weak var selectedImage : UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBar()
        hideKeyboard()
        NavigationBarView.dropShadow()
        NavigationBarView.roundCorners(corners: .layerMinXMaxYCorner, radius: 30)
        textView.layer.cornerRadius = 10
        bottomView.dropShadow()
        textView.layer.borderWidth = 1
        if #available(iOS 13.0, *) {
            textView.layer.borderColor = UIColor.systemGray4.cgColor
        } else {
            textView.layer.borderColor = UIColor.gray.cgColor
        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
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
        if textView.text != "" {
            if postTitleTF.text != ""{
                let post = CreatePost(date: date, desc: textView.text ?? "test", image: selectedImage.image ?? #imageLiteral(resourceName: "art2"), medium: "Oild", size: "3x1", time: time, title: postTitleTF.text ?? "Test" , user: Auth.auth().currentUser!.uid)
                
                PostService.shared.creatPost(account: .artist, post: post) { [self] (eror, ref) -> (Void) in
                    if eror == nil{
                        self.presentAlert(withTitle: "Success", message: "Post Uploaded")
                        postTitleTF.text = ""
                        textView.text = ""
                        selectedImage.image = nil
                    }
                    else{
                        print(eror?.localizedDescription as Any)
                    }
                }
            }
        }
        else{
            self.presentAlert(withTitle: "Error", message: "Fill the TextFields")
        }
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


