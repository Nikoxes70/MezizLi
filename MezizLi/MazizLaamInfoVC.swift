//
//  MazizLaamInfoVC.swift
//  MezizLi
//
//  Created by Nikolai Volodin on 06/03/2016.
//  Copyright © 2016 Nikolai Volodin. All rights reserved.
//

import UIKit

class MazizLaamInfoVC: UIViewController {
    
    @IBOutlet weak var voteUp: UILabel!
    @IBOutlet weak var voteDown: UILabel!
    @IBOutlet weak var productTtl: UILabel!
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productDescriptionText: UITextView!
    
    
    private var Name:String="";
    private var VoteUp:Int=0;
    private var VoteDown:Int=0;
    private var Description:String="";
    private var pic:UIImage = UIImage(named: "group")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //productImg.image = UIImage(named: "group")!
        
        productTtl.text=Name;
        voteUp.text = "\(VoteUp)";
        voteDown.text = "\(VoteDown)";
        productDescriptionText.text=Description;
        productImg.image=pic;
        
        
    }
    
    @IBAction func voteUp(sender: UIButton) {
        
    }
    
    @IBAction func voteDown(sender: UIButton) {
    }
    
    func setSelectedProduct(Pname:String,PvoteUp:Int,PvoteDown:Int,Pdescription:String,Pimg:UIImage)
    {
        self.Name=Pname;
        self.VoteUp=PvoteUp;
        self.VoteDown=PvoteDown;
        self.Description=Pdescription;
        self.pic=Pimg;
    }
}
