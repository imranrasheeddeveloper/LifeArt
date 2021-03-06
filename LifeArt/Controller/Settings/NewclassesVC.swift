//
//  NewclassesVC.swift
//  LifeArtCopy
//
//  Created by macbook on 4/26/21.
//

import UIKit
import Firebase
import MaterialComponents.MDCOutlinedTextField
class NewclassesVC: UIViewController, UINavigationControllerDelegate {
  
    //MARK:-OUTLETS
    
    @IBOutlet weak var navigationView : UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var website: MDCOutlinedTextField!
    @IBOutlet weak var discription: MDCOutlinedTextField!
    @IBOutlet weak var phoneNumber: MDCOutlinedTextField!
    @IBOutlet weak var address: MDCOutlinedTextField!
    @IBOutlet weak var ownerName: MDCOutlinedTextField!
    @IBOutlet weak var nameOfInsitutue: MDCOutlinedTextField!


    
    //MARK:-Variables
    var flag = false
    
    //MARK:-LIfeCycels
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBar()
        hideKeyboard()
        navigationView.dropShadow()
        navigationView.roundCorners(corners: .layerMinXMaxYCorner, radius: 30)
        self.imageView.isUserInteractionEnabled  = true
        addgesture()
        let tap = UITapGestureRecognizer(target: self, action: #selector(imagePickerAction))
        self.imageView.addGestureRecognizer(tap)
        setupTexfields()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    //MARK:-Helper Functions
    
    func setupTexfields(){
        website.label.text = "Website"
        discription.label.text = "Discription"
        phoneNumber.label.text = "Contact"
        address.label.text = "Address"
        ownerName.label.text = "Owner Name"
        nameOfInsitutue.label.text = "Name of Insitute"
        
        
        website.sizeToFit()
        discription.sizeToFit()
        phoneNumber.sizeToFit()
        address.sizeToFit()
        ownerName.sizeToFit()
        nameOfInsitutue.sizeToFit()
        
        website.containerRadius = 10
        phoneNumber.containerRadius = 10
        discription.containerRadius = 10
        address.containerRadius = 10
        ownerName.containerRadius = 10
        nameOfInsitutue.containerRadius = 10
        
        website.verticalDensity = 40
        phoneNumber.verticalDensity = 40
        //discription.verticalDensity = 40
        address.verticalDensity = 40
        ownerName.verticalDensity = 40
        nameOfInsitutue.verticalDensity = 40
    }
    
    
    func addgesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(openSheet))
        self.imageView.addGestureRecognizer(tap)
    }
    
    @objc func openSheet(){
        showActionSheet()
       
    }
    
    @IBAction func backButton(sender  :UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func saveClass(_ sender: UIButton) {
        apiCalling()
    }
    
    
    //MARK:- API Calling
     
    func apiCalling()  {
        let classs = ClassModel(address: address.text!, date: currentDate(), desc: discription.text!, image: imageView.image ?? #imageLiteral(resourceName: "art3"), name: nameOfInsitutue.text!, owner: ownerName.text!, phone: phoneNumber.text!, time: currentTime(), user: Auth.auth().currentUser!.uid, web: website.text!)
        ClassesService.shared.creatPost(classModel: classs) { (error, ref) -> (Void) in
            if error == nil {
//                self.presentAlertWithDissmissVC(withTitle: "Success", message: "Class Uploaded")
                snackBar(str: "Class Uploaded")
            }
        }
    }
    
    func validation() {
        if address.text == "" {
            if discription.text == ""{
                if website.text == ""{
                    if nameOfInsitutue.text == ""{
                        if ownerName.text == ""{
                            apiCalling()
                        }
                    }
                }
            }
        }
    }
    
    
    @objc func imagePickerAction() {
        let alert = UIAlertController(title: "Title", message: "Please Select an Option", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Camera", style: .default , handler:{ (UIAlertAction)in
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.delegate = self
                picker.allowsEditing = false
                self.present(picker, animated: true)
            }))
            
            alert.addAction(UIAlertAction(title: "Photos", style: .default , handler:{ (UIAlertAction)in
                
                let picker = UIImagePickerController()
                picker.sourceType = .photoLibrary
                picker.delegate = self
                self.present(picker, animated: true)
                
            }))
            
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
               
            }))

            
            //uncomment for iPad Support
            //alert.popoverPresentationController?.sourceView = self.view

            self.present(alert, animated: true, completion: {
                print("completion block")
            })
    }
   

}

//extension NewclassesVC :UIImagePickerControllerDelegate,UINavigationControllerDelegate{
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        picker.dismiss(animated: true, completion: nil)
//    }
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        picker.dismiss(animated: true, completion: nil)
//        guard let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
//            return
//        }
//        imageView.image = originalImage
//    }
//}
extension NewclassesVC : UIImagePickerControllerDelegate{
    func camera()
    {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerController.SourceType.camera
        self.present(myPickerController, animated: true, completion: nil)
    }
    func photoLibrary()
    {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(myPickerController, animated: true, completion: nil)
    }
    func showActionSheet() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: UIAlertAction.Style.default, handler: { (alert:UIAlertAction!) -> Void in
            self.camera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: UIAlertAction.Style.default, handler: { (alert:UIAlertAction!) -> Void in
            self.photoLibrary()
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        if let image = image{
            imageView.image = image
            flag  = true
            let imgData = NSData(data: image.jpegData(compressionQuality: 1)!)
            let imageSize: Int = imgData.count
            print("actual size of image in KB: %f ", Double(imageSize) / 1000.0)
        }
        else{
            print("Image is too large. Select an image under 5MB")
        }
        self.dismiss(animated: true, completion: nil)
    }
}



