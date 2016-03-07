//
//  RegisterVC.swift
//  Maziz li
//
//  Created by Nikolai Volodin on 02/03/2016.
//  Copyright © 2016 itzik nehemya. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {
    var isOk = false
    @IBOutlet weak var txtEmailRegVC: UITextField!
    @IBOutlet weak var txtFirstRegVC: UITextField!
    @IBOutlet weak var txtLastRegVC: UITextField!
    @IBOutlet weak var txtPhoneRegVC: UITextField!
    
    @IBOutlet weak var ERROR: UILabel!
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    @IBAction func registration(sender: UIButton) {
        fullFormVerification() ? addUserAndLogin() : ()
    }
    func verifyEmail(email:String)->Bool{
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if emailTest.evaluateWithObject(email){
            return true
        }else{
            alertERROR("Your email is invalid!")
        }
        return false
    }
    func verifyName(f:String,l:String)->Bool{
        if f.characters.count >= 2 && l.characters.count >= 2{
            return true
        }else{
            alertERROR("Name/LastName must contain at least 2 characters")
        }
        return false
    }
    func fullFormVerification()->Bool{
        return verifyEmail(txtEmailRegVC.text!) && verifyName(txtFirstRegVC.text!, l: txtLastRegVC.text!) && verifyPhone()
    }
    func verifyPhone()->Bool{
        if (Validator().getValidPhoneNumber(txtPhoneRegVC.text!)) != nil{
            return true
        }else{
            alertERROR("Your phone numbe is invalid")
        }
        return false
    }
    func alertERROR(txt:String){
        self.ERROR.text = txt//setting the error.txt lbl
        
        //creating first animation "FadeIn"
        UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.ERROR.alpha = 1.0
            }, completion: {
                (finished: Bool) -> Void in
                
                // create the second animation "FadeOut"
                UIView.animateWithDuration(1.0, delay: 2.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                    self.ERROR.alpha = 0.0
                    }, completion: nil)
        })
    }
    func addUserAndLogin(){
        let UDefaluts = NSUserDefaults.standardUserDefaults();
        
        UDefaluts.setValue(txtPhoneRegVC.text!, forKey: "LoggedUser");
        
        print(Client().addUser(txtFirstRegVC.text!, lastName: txtLastRegVC.text!, email: txtEmailRegVC.text!, phoneNumber: txtPhoneRegVC.text!));
        
        isOk = true
    }
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "login"{
            return isOk
        }
        return true
    }
    
}
