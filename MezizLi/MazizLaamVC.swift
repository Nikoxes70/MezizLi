//
//  MazizLaumViewController.swift
//  Maziz li
//
//  Created by itzik nehemya on 02/03/2016.
//  Copyright © 2016 itzik nehemya. All rights reserved.
//

import UIKit

class MazizLaamVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    let UDefaults = NSUserDefaults.standardUserDefaults();
    
    @IBOutlet weak var tableView: UITableView!
    var name:String = "";
    override func viewDidAppear(animated: Bool) {
        //UDefaults.removeObjectForKey("LoggedUser")
        if let s = UDefaults.objectForKey("LoggedUser"){
            print("wellcome \(s)")
        }else{
            performSegueWithIdentifier("register", sender: self)
        }
    }
    override func viewDidLoad() {
        DBClient.products.removeAll();
       getDataFromServer()
        //tableView.allowsSelection = false;
    }
    @IBAction func backToMaziz(sender:UIStoryboardSegue){}
    func getDataFromServer(){
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: "http://www.itzikne.5gbfree.com/DBProducts/getDataPhp.php")!, completionHandler: {d,r,e in
           
            self.readJSON(d!)
            
        }).resume();

    }
    //read from the server
    private func readJSON(d:NSData)
    {
        var json:[[String:AnyObject]];
        do{
            
            json = (try NSJSONSerialization.JSONObjectWithData(d, options: [])) as! Array
            
        }catch{
            
            json = [];
        }
        
        for i in json
        {
            AsyncTask(backgroundTask: {(i)in
                
                var image : UIImage?
                let category = (i["category"]! as! String);
                let name = (i["name"]! as! String);
                let description = (i["description"]! as! String);
                let voteUp = (i["voteUp"]! as! String);
                let voteDown = (i["voteDown"]! as! String);
                let img = (i["img"]! as! String);
                let date = 0.0
                let user = (i["owner"]! as! String)
                let UPC = ""
                print(user);
                
                if let url = NSURL(string: img){
                    if let data = NSData(contentsOfURL: url){
                        image = UIImage(data: data)!
                    }
                }
                let newProduct = Product(itemName: name, itemDescription: description, itemCategory: category, itemVoteUp: Int(voteUp)!, itemVoteDown: Int(voteDown)!, currentDate: date, UPC: UPC, user: user, img: image);
                
                if let loggedUser = self.UDefaults.objectForKey("LoggedUser") as? String{
                    if loggedUser == newProduct.user{
                        DBClient.myProducts.append(newProduct)
                    }
                }
                
                DBClient.products.append(newProduct)
                
                }, afterTask: {()in
                    self.tableView.reloadData()
            }).execute(i)
        }
    }
    //number sec in table
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    //number of row in table
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DBClient.products = ProductSorter.sortProductByVotes(DBClient.products)
        return DBClient.products.count;
    }
    
    // display name in eath row
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! ProductCTBC
        
        cell.ttlForCell.text = DBClient.products[indexPath.row].name;
        cell.imgForCell?.image = DBClient.products[indexPath.row].img;
        //
        cell.imgForCell.clipsToBounds=true;
        //cell.imgForCell?.layer.borderWidth = CGFloat(1.0);
        //cell.imgForCell?.layer.borderColor = UIColor.yellowColor().CGColor
        cell.imgForCell?.layer.cornerRadius = CGFloat(55);
        //
        cell.voteUpTTL.text = "\(DBClient.products[indexPath.row].voteUp)";
        cell.voteDownTTL.text = "\(DBClient.products[indexPath.row].voteDown)";
     
        
        return cell;
    }

    //do action on click on 1 row
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        let nextScreen = storyboard?.instantiateViewControllerWithIdentifier("productINFO") as! MazizLaamInfoVC;
        
        let product=DBClient.products[indexPath.row];
        
        
        nextScreen.setSelectedProduct(product.name, PvoteUp: product.voteUp, PvoteDown: product.voteDown, Pdescription: product.description,Pimg: product.img!)
       
        
        
        showViewController(nextScreen, sender: self);
        
    }
}
