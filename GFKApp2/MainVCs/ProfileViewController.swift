//
//  ProfileViewController.swift
//  GFKApp2
//
//  Created by Deniz Can Ilgın on 2.03.2020.
//  Copyright © 2020 GFK Girişimcilik ve İnovasyon Sportif Gençlik Platformu. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var PPImageView: UIImageView!
    var localPhoto:UIImage!

    @IBAction func LogOutAction(_ sender: Any) {
        
        PFUser.logOut()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                                                     let controller = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
                                                                     controller.modalPresentationStyle = .fullScreen
                                                                     self.present(controller, animated: true, completion: nil)
        
        
        
    }
    @IBOutlet weak var ImageViewProfilePhoto: UIImageView!
    @IBOutlet weak var TextFieldFullName: UITextField!
    @IBOutlet weak var TextFieldTitle: UITextField!
    @IBOutlet weak var TextFieldSchool: UITextField!
    
    //Dismiss keyboard method
          func keyboardDismiss() {
              TextFieldFullName.resignFirstResponder()
              TextFieldTitle.resignFirstResponder()
              TextFieldSchool.resignFirstResponder()
          }

          //ADD Gesture Recignizer to Dismiss keyboard then view tapped
          @IBAction func viewTapped(_ sender: AnyObject) {
              keyboardDismiss()
          }

          //Dismiss keyboard using Return Key (Done) Button
          //Do not forgot to add protocol UITextFieldDelegate
          func textFieldShouldReturn(_ textField: UITextField) -> Bool {
              keyboardDismiss()

              return true
          }
       
    
    @IBOutlet weak var LabelPoint: UILabel!
    override func viewDidLoad() {
            super.viewDidLoad()
        
        
        ButtonSave.layer.cornerRadius = 10
              ButtonSave.clipsToBounds = true

        
            // Do any additional setup after loading the view.
            
            ImageViewProfilePhoto.layer.cornerRadius = 15;
            ImageViewProfilePhoto.image = #imageLiteral(resourceName: "ppdefault")
            
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.imageTapped(gesture:)))

           // add it to the image view;
           PPImageView.addGestureRecognizer(tapGesture)
           // make sure imageView can be interacted with by user
           PPImageView.isUserInteractionEnabled = true
            
            retrieveAndFillProfileIfNotEmpty()
            
        }
    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
          // if the tapped view is a UIImageView then set it to imageview
          if (gesture.view as? UIImageView) != nil {
              print("Image Tapped")
              //Here you can initiate your new ViewController
            
             showUserActionMenu(title: "Çıkış Yap",message: "Çıkış yapmak istediğinizden emin misiniz?")

        }}

    override func viewDidAppear(_ animated: Bool) {
        
        removeSpinner()
            retrieveAndFillProfileIfNotEmpty()
            PPImageView.image = userProfileImageView
            PPImageView.setRounded()
        }
    
    @IBAction func UpdateProfilePhotoAction(_ sender: Any) {
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))

        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))

        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
        
    }
    @IBOutlet weak var ButtonSave: UIButton!
    
    @IBAction func SaveProfileAction(_ sender: Any) {
        
        self.showSpinner(onView: self.view)
    
        
        let entered_full_name = TextFieldFullName.text
        let entered_title = TextFieldTitle.text
        let entered_school = TextFieldSchool.text
        
          let userId = PFUser.current()?.objectId
          var query = PFUser.query()
                query?.getObjectInBackground(withId: userId!){(user,error) in
        
                    if(error == nil){

                        user?["full_name"] = entered_full_name
                        user?["title"] = entered_title
                        user?["school"] = entered_school
                        
                        if(self.localPhoto != nil){
                            
                            
                            
                            let imageDataBeforeCompression = self.localPhoto.pngData()
                            print("size before compression: \(imageDataBeforeCompression!.count) ")
                        
    
                            
                            let imageData = self.localPhoto.jpeg(.lowest)
                             print("size after compression: \(imageData!.count) ")
                            let imageFile = PFFileObject(name:"image2.png", data:imageData!)
                            user?["Photo"] = imageFile
                           
                        
                        }
                        user?.saveInBackground { (succeeded, error)  in
                            if (succeeded) {
                                // The object has been saved.
                                print("UserProfileSuccessFullySaved!")
                                self.showAlert(title: "Başarılı!", message: "Profiliniz başarıyla güncellendi!")
                                self.removeSpinner()
                                
                            } else {
                                // There was a problem, check error.description
                                
                                self.showAlert(title: "Başarısız!", message: "Profiliniz güncellenirken bir hata meydana geldi")
                                                     self.removeSpinner()
                                
                            }
                        }
                        
                    }
        
                }
        
        
    }
    
    func showUserActionMenu(title:String,message:String){
         
          let alert = UIAlertController(title: "" + title, message: "" + message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Çıkış Yap", style: .default, handler: { action in
                 
                 PFUser.logOut()
                 let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                   let controller = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
                                   controller.modalPresentationStyle = .fullScreen
                                   self.present(controller, animated: true, completion: nil)
                 
                  
                }))
                alert.addAction(UIAlertAction(title: "Vazgeç", style: .default, handler: nil))
                self.present(alert, animated: true)
         
     }
     
    func retrieveAndFillProfileIfNotEmpty(){
            
         
            let query = PFUser.query()
            query?.getObjectInBackground(withId: PFUser.current()!.objectId!){(user,error) in
    
                if(error == nil){
    
                    let full_name = ((user?["full_name"] as? String))
                    let title = ((user?["title"] as? String))
                    let school = ((user?["school"] as? String))
                    let photo = ((user?["Photo"] as? PFFileObject))
                    let point = ((user?["Point"] as? Int))
                    photo?.getDataInBackground(block: { (data, error) in
                        
                        if(error == nil){
                            
                            let image = UIImage(data: data!)
                            if(image != nil){
                                                   
                                                   self.ImageViewProfilePhoto.image = image
                                self.ImageViewProfilePhoto.setRounded()
                                               }
                        }
                        
                    })
                    
                   
                    if(point != nil){
                        self.LabelPoint.text = "Toplam Puan: \(point!)"
                                    
                    }else{
                        self.LabelPoint.text = "Toplam Puan: 0"
                    }
                    
                    if(full_name != nil){
                        self.TextFieldFullName.text = full_name
                        print("UserRetrievedSuccessfully:" + full_name!)}
    
                    if(title != nil){
                        self.TextFieldTitle.text = title
                        print("UserRetrievedSuccessfully:" + title!)}
    
                    if(school != nil){
                        self.TextFieldSchool.text = school
                        print("UserRetrievedSuccessfully:" + school!)}
    
    
    
                }
    
            }
    
        

            
        }
    
    func showAlert(title:String,message:String){
          
          let alert = UIAlertController(title: "" + title, message: "" + message, preferredStyle: .alert)

          alert.addAction(UIAlertAction(title: "Anladım", style: .default, handler: nil))
          self.present(alert, animated: true)
          
      }
    
    func openCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
      func openGallery()
     {
         if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
             let imagePicker = UIImagePickerController()
             imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
             imagePicker.allowsEditing = true
             imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
             self.present(imagePicker, animated: true, completion: nil)
         }
         else
         {
             let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
             self.present(alert, animated: true, completion: nil)
         }
     }
    

}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("\(info)")
        if let image = info[.originalImage] as? UIImage {
            self.ImageViewProfilePhoto?.image = image
            self.localPhoto = image
            
            self.ImageViewProfilePhoto.setRounded()
            self.ImageViewProfilePhoto.contentClippingRect
    
            
            dismiss(animated: true, completion: nil)
        }
    }


}

extension UIImageView {

   func setRounded() {
//     let radius = self.frame.width/2
//      self.layer.cornerRadius = radius
//      self.layer.masksToBounds = true
    
    
    self.layer.borderWidth = 2
    self.layer.masksToBounds = true
    self.layer.borderColor = UIColor.white.cgColor
    self.layer.cornerRadius = self.frame.height/2
    self.clipsToBounds = true
    
   }
        
}

extension UIImageView {
    var contentClippingRect: CGRect {
        guard let image = image else { return bounds }
        guard contentMode == .scaleAspectFit else { return bounds }
        guard image.size.width > 0 && image.size.height > 0 else { return bounds }

        let scale: CGFloat
        if image.size.width > image.size.height {
            scale = bounds.width / image.size.width
        } else {
            scale = bounds.height / image.size.height
        }

        let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        let x = (bounds.width - size.width) / 2.0
        let y = (bounds.height - size.height) / 2.0

        return CGRect(x: x, y: y, width: size.width, height: size.height)
    }
    
}

var vSpinner : UIView?

extension UIViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
    
    func showProfileAction(){
        
        
        print("ProfileAction");
        
    }
    
    
   
}


extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }

    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}
