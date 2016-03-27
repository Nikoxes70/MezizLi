//
//  LoginVC.swift
//  MezizLi
//
//  Created by Nikolai Volodin on 09/03/2016.
//  Copyright © 2016 Nikolai Volodin. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
var isOk = false
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var loader: UIActivityIndicatorView!

    func loginUser(phone:String){
        let request = NSMutableURLRequest(URL: NSURL(string:"http://www.itzikne.5gbfree.com/DBUsers/loginPostData.php")!);
        
        request.HTTPMethod = "POST";
        
        request.HTTPBody = "phoneNumber=\(phone)".dataUsingEncoding(NSUTF8StringEncoding);
        
            NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {(d,r,e)in
                if e == nil{
                    
                    self.loader.hidden = true
                    
                    let result = String(data: d!, encoding: NSUTF8StringEncoding)!;
                    if result.rangeOfString("success") != nil{
                        self.isOk = true
                        self.moveNext()
                    }else{
                        self.dialog("משתמש לא קיים במערכת")
                    }
                    
                }else{
                    print("server error")
                }
            }).resume()
            
    }
    override func viewWillAppear(animated: Bool) {
        addUnderline(phone)
    }
    override func viewDidAppear(animated: Bool) {
        loader.hidden = true
    }
    @IBAction func login(sender: UIButton) {
        loader.hidden = false
        loader.startAnimating()
       
        if (Validator().getValidPhoneNumber(phone.text!)) != nil{
        loginUser(phone.text!)
        }else{
            loader.hidden = true
            dialog("מספר טלפון לא תקין")
        }
    }
    func dialog(txt:String){
        let dialog = UIAlertController(title: "שגיעה", message: txt, preferredStyle: .Alert)
        dialog.addAction(UIAlertAction(title: "אשר", style: .Cancel, handler: nil))
        self.presentViewController(dialog, animated: true, completion: nil)
    }
    func logged(){
        performSegueWithIdentifier("", sender: self)
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "login"{
            return isOk
        }
        return true
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
    func moveNext(){
        let UDefaluts = NSUserDefaults.standardUserDefaults();
        UDefaluts.setValue(self.phone.text!, forKey: "LoggedUser");
        self.performSegueWithIdentifier("login", sender: self)
    }
}
