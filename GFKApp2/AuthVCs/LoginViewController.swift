//
//  LoginViewController.swift
//  GFKApp
//
//  Created by Deniz Can Ilgın on 25.02.2020.
//  Copyright © 2020 GFK Girişimcilik ve İnovasyon Sportif Gençlik Platformu. All rights reserved.
//

import UIKit
import Parse





class LoginViewController: UIViewController {
    
    @IBOutlet weak var TextFieldEmail: UITextField!
    @IBOutlet weak var TextFieldPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {


    }
    
     
   
    
    
    
    
    @IBAction func LoginButtonAction(_ sender: Any) {
 
        let enteredUsername = TextFieldEmail.text!
        let enteredPassWord = TextFieldPassword.text!
        
        if(enteredUsername.count < 5){showAlert(title: "Hata!", message: "Lütfen geçerli bir kullanıcı adı giriniz.")}
        if(enteredPassWord.count < 5){showAlert(title: "Hata!", message: "Lütfen geçerli bir şifre giriniz.")}
        
        self.loginUserToParse(username:enteredUsername,password:enteredPassWord)
            
    }
    
    @IBAction func GoRegisterButtonAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let controller = storyboard.instantiateViewController(withIdentifier: "RegisterViewController")
        
               self.present(controller, animated: true, completion: nil)
        
    }
    
    func succesfullLogin(){
        
                
        checkIsSurveyFilled()
         
    }
    
    func loginUserToParse(username:String,password:String) {
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            
            if(error == nil){
                
                print("ParseAuth:","Successfully Logged In!")
                self.succesfullLogin()
                
            }else{
                
                print("ParseAuth:","Error:" + error!.localizedDescription)
                self.showAlert(title: "Hatalı Bilgiler", message: "Lütfen size gönderilen kullanıcı adı ve şifre bilgileri ile giriş yapınız. Eğer hala hata alıyorsanız; merhaba@gfkgenclikplatformu.com adresinden iletişim kurunuz.")
                
                
            }

        }

    
    }
    
    func showAlert(title:String,message:String){
        
        let alert = UIAlertController(title: "" + title, message: "" + message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Anladım", style: .default, handler: nil))
        self.present(alert, animated: true)
        
    }
    
    func checkIsSurveyFilled(){
         
         let query = PFQuery(className: "Survey");
         query.whereKey("userId", equalTo: PFUser.current()?.objectId)
         query.findObjectsInBackground { (results, error) in
             
             if(error == nil){
                 
                 if(results!.count > 0 ){
                     
                     //transfer other page directly
                                          let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                          let controller = storyboard.instantiateViewController(withIdentifier: "MainViewController")
                                          controller.modalPresentationStyle = .fullScreen
                                          self.present(controller, animated: true, completion: nil)
                     
                 }else{
                    

                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "SurveyViewController")
                    controller.modalPresentationStyle = .fullScreen
                    self.present(controller, animated: true, completion: nil)

                    
                }
                 
             }
             
             
         }
         
     }
    
    //Dismiss keyboard method
    func keyboardDismiss() {
        TextFieldEmail.resignFirstResponder()
        TextFieldPassword.resignFirstResponder()
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
    
}
