//
//  LaunchScreenVC.swift
//  MezizLi
//
//  Created by itzik nehemya on 08/03/2016.
//  Copyright © 2016 Nikolai Volodin. All rights reserved.
//

import UIKit

class LaunchScreenVC: UIViewController {

    @IBOutlet weak var barprogress: UIProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        performSelector(Selector("startApp"), withObject: nil, afterDelay: 2.5)
        
        barprogress.setProgress(1.0, animated: true);
        
    }
    
    func startApp()
    {
        performSegueWithIdentifier("startApp", sender: self);
    }
    
    


}
