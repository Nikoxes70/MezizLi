//
//  RegisterVC.swift
//  Maziz li
//
//  Created by Nikolai Volodin on 02/03/2016.
//  Copyright © 2016 itzik nehemya. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {
    @IBOutlet weak var loader: UIActivityIndicatorView!
    var isOk = false
    @IBOutlet weak var txtEmailRegVC: UITextField!
    @IBOutlet weak var txtFirstRegVC: UITextField!
    @IBOutlet weak var txtLastRegVC: UITextField!
    @IBOutlet weak var txtPhoneRegVC: UITextField!
    
    @IBOutlet weak var ERROR: UILabel!
   
    func addUser(firstName:String, lastName:String, email:String, phoneNumber:String){
        
        print("\(firstName),\(lastName),\(email),\(phoneNumber)");
        
        let request = NSMutableURLRequest(URL: NSURL(string:"http://www.itzikne.5gbfree.com/DBUsers/postDataPhp.php")!);
        
        request.HTTPMethod = "POST";
        
                request.HTTPBody = "firstName=\(firstName)&lastName=\(lastName)&email=\(email)&phoneNumber=\(phoneNumber)".dataUsingEncoding(NSUTF8StringEncoding);

        NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {(d,r,e)in
            AsyncTask(backgroundTask: { ()->String in
                
                var result = ""
                if e == nil{
                result = String(data: d!, encoding: NSUTF8StringEncoding)!
                }
                
                return result
                
                }, afterTask: {(result)in
                    self.loader.hidden = true
                    if result.rangeOfString("success") != nil{
                        self.goOn()
                    }else if result.rangeOfString("number") != nil{
                        self.dialogERROR("Error", body: "This phone number already registered")
                    }else{
                        self.dialogERROR("Error", body: "Some internet issues please try again later")
                    }
            }).execute()
            }).resume()
    
    }
    
    override func viewWillAppear(animated: Bool) {
              addUnderline(txtPhoneRegVC)
              addUnderline(txtEmailRegVC)
              addUnderline(txtLastRegVC)
              addUnderline(txtFirstRegVC)
        
        loader.hidden = true
    }
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
        loader.hidden = false
        loader.startAnimating()
        let UDefaluts = NSUserDefaults.standardUserDefaults();
        
        UDefaluts.setValue(txtPhoneRegVC.text!, forKey: "LoggedUser");
        
        addUser(txtFirstRegVC.text!, lastName: txtLastRegVC.text!, email: txtEmailRegVC.text!, phoneNumber: txtPhoneRegVC.text!);
        //print("is!"+s)
        
    }
    func goOn(){
       
        isOk = true
        performSegueWithIdentifier("registerNew", sender: self)
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "registerNew"{
            return isOk
        }
        return true
    }
    func dialogERROR(ttl:String,body:String){
        let dialog = UIAlertController(title: ttl, message: body, preferredStyle: .Alert)
        dialog.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
        self.presentViewController(dialog, animated: true, completion: nil)
    }
    func addUnderline(txt:UITextField){
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.grayColor().CGColor
        border.frame = CGRect(x: 0, y: txt.frame.size.height - width, width:  txt.frame.size.width, height: txt.frame.size.height)
        
        border.borderWidth = width
        txt.layer.addSublayer(border)
        txt.layer.masksToBounds = true
    }
}
