//
//  SignVC.swift
//  MezizLi
//
//  Created by Nikolai Volodin on 09/03/2016.
//  Copyright © 2016 Nikolai Volodin. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class SignVC: UIViewController{
    
    @IBOutlet weak var loginButton:FBSDKLoginButton!
    
    @IBAction func backToSign(segue:UIStoryboardSegue){}//unwind segue to SignVC
    
    override func viewWillAppear(animated: Bool) {
        
        self.loginButton.readPermissions = ["public_profile", "email"]
        
      //  let loginButton: FBSDKLoginButton = FBSDKLoginButton()
       // loginButton.center = self.view.center
        //self.view!.addSubview(loginButton)
    }
}
