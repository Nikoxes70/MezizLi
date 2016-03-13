//
//  MazizLaamInfoVC.swift
//  MezizLi
//
//  Created by Nikolai Volodin on 06/03/2016.
//  Copyright © 2016 Nikolai Volodin. All rights reserved.
//

import UIKit

class MazizLaamInfoVC: UIViewController {
    
    let DBC = DBClient.getDBClient()
    
    var toReload = false
    let ud = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var error: UILabel!
    @IBOutlet weak var voteUp: UILabel!
    @IBOutlet weak var voteDown: UILabel!
    @IBOutlet weak var productTtl: UILabel!
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productDescriptionText: UITextView!

    
    private var isOk:String="";
    private var indexPathForRow:Int=0;
    private var Name:String="";
    private var VoteUp:Int=0;
    private var VoteDown:Int=0;
    private var Description:String="";
    private var pic:UIImage = UIImage(named: "group")!
    private var productId:Int=0;
    private var userId:String=""
    private var userAreVoted:String=""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userId = (ud.objectForKey("LoggedUser") as? String)!
        productTtl.text=Name;
        voteUp.text = "\(VoteUp)";
        voteDown.text = "\(VoteDown)";
        productDescriptionText.text=Description;
        productImg.image=pic;
        print(productId);

        
        
    }
    
    func setSelectedProduct(Pname:String,PvoteUp:Int,PvoteDown:Int,Pdescription:String,Pimg:UIImage,id:Int,Voted:String)
    {
        self.Name=Pname;
        self.VoteUp=PvoteUp;
        self.VoteDown=PvoteDown;
        self.Description=Pdescription;
        self.pic=Pimg;
        self.productId=id;
        self.userAreVoted=Voted;
    }
    

    
    @IBAction func voteUp(sender: UIButton) {
        
        if((userAreVoted.rangeOfString(userId)) != nil)
        {
            print("voted");
            alertERROR("כבר הצבעת!!!")
        }
        else{
            
            self.voteUpIng(self.productId);
            self.voteUp.text="\(self.VoteUp+1)";
            self.userAreVoted.appendContentsOf(self.userId);
            updatvoteUpToProduct();//
        }
    }
    
    @IBAction func voteDown(sender: UIButton) {
        
        if((userAreVoted.rangeOfString(userId)) != nil)
        {
            print("voted");
            alertERROR("כבר הצבעת!!!")
        }
        else{
            voteDownIng(productId)
            voteDown.text="\(VoteDown+1)"
            self.userAreVoted.appendContentsOf(userId);
            updatvoteDownToProduct();
        }
    }
  
    //voteing Up
    func voteUpIng(id:Int){
        let request = NSMutableURLRequest(URL: NSURL(string:"http://www.itzikne.5gbfree.com/DBProducts/voteUpInProduct.php")!);
        
        request.HTTPMethod = "POST";
        
        request.HTTPBody = "voted=,\(userId)&id=\(id)".dataUsingEncoding(NSUTF8StringEncoding);
        
        NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {(d,r,e)in
            
            print(String(data: d!, encoding: NSUTF8StringEncoding)!);
            
        }).resume()
    }
    
    //voteing Down
    func voteDownIng(id:Int){
        let request = NSMutableURLRequest(URL: NSURL(string:"http://www.itzikne.5gbfree.com/DBProducts/voteDownInProduct.php")!);
        
        request.HTTPMethod = "POST";
        
        request.HTTPBody = "voted=,\(userId)&id=\(id)".dataUsingEncoding(NSUTF8StringEncoding);
        
        NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {(d,r,e)in
            
            print(String(data: d!, encoding: NSUTF8StringEncoding)!);
            
        }).resume()
    }
    
    
    //show error ttl
    func alertERROR(txt:String){
        self.error.text = txt//setting the error.txt lbl
        
        //creating first animation "FadeIn"
        UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.error.alpha = 1.0
            }, completion: {
                (finished: Bool) -> Void in
                
                // create the second animation "FadeOut"
                UIView.animateWithDuration(1.0, delay: 2.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                    self.error.alpha = 0.0
                    }, completion: nil)
        })
    }
    
    //
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if toReload{
            let d = segue.destinationViewController as! MazizLaamVC
            d.tableView.reloadData()
        }
    }

    
    func Loader(){
        if(isOk=="ok"){
           loader.hidden=false;
        }
        
    }
    
    //update the voteUP to UI
    func updatvoteUpToProduct(){
        for(var i=0; i < DBC.products.count; i++){
            if DBC.products[i].id == productId{
                DBC.products[i].voteUp++;
                DBC.products[i].voted.appendContentsOf(userId)
                self.toReload = true
            }
        }
    
        
    }
    
    //update the voteDown to UI
    func updatvoteDownToProduct(){
        for(var i=0; i<DBC.products.count; i++){
            if DBC.products[i].id == productId{
                DBC.products[i].voteDown++;
                DBC.products[i].voted.appendContentsOf(userId)
                self.toReload = true
            }
        }
       
    }
}