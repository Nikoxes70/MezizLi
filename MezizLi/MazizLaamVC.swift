//
//  MazizLaumViewController.swift
//  Maziz li
//
//  Created by itzik nehemya on 02/03/2016.
//  Copyright © 2016 itzik nehemya. All rights reserved.
//

import UIKit

class MazizLaamVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    var name:String = "";
    
    override func viewDidLoad() {
        
        DBClient.products.removeAll();
        //DBClient.pics.removeAll();
        
//        AsyncTask(backgroundTask: {()->[Product] in
//            return Client().getDataFromServer();
//            }, afterTask: {(db:[Product])in
//         self.tableView.reloadData();
//                
//                print("the end")
//                for i in db{
//                    print("\(i.name)")
//                }
//                
//        }).execute()
        //Client().getDataFromServer();
       getDataFromServer()
        
       
    }
    @IBAction func backToMaziz(sender:UIStoryboardSegue){
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    
    func getDataFromServer()
    {
        
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: "http://www.itzikne.5gbfree.com/DBProducts/getDataPhp.php")!, completionHandler: {d,r,e in
           
            self.readJSON(d!)
            
        }).resume();
        
        // print(db)
        //return db
    }
    
    
    //read from the server
    private func readJSON(d:NSData)//->[Product]
    {
        var image : UIImage?
        
        var json:[[String:AnyObject]];
        do{
            
            json = (try NSJSONSerialization.JSONObjectWithData(d, options: [])) as! Array
            
        }catch{
            
            json = [];
        }
     
        for i in json
        {
            let category = (i["category"]! as! String);
            let name = (i["name"]! as! String);
            let description = (i["description"]! as! String);
            let voteUp = (i["voteUp"]! as! String);
            let voteDown = (i["voteDown"]! as! String);
            let img = (i["img"]! as! String);
            let date = 0.0
            let user = ""
            let UPC = ""
            
            
            if let url = NSURL(string: img){
                if let data = NSData(contentsOfURL: url){
                    image = UIImage(data: data)!
                }
            }
            
            
            //DBClient.pics.append(UIImage(data: data!)!)
            
            //DBClient.products.append(["name": "\(name)", "description": "\(description)","voteUp":"\(voteUp)", "voteDown": "\(voteDown)", "category": "\(category)"])
            
            DBClient.products.append(Product(itemName: name, itemDescription: description, itemCategory: category, itemVoteUp: Int(voteUp)!, itemVoteDown: Int(voteDown)!, date: date, UPC: UPC, user: user, img: image))
            
        }
        self.tableView.reloadData()
       // MazizLaamVC().reload()
        //return DBClient.products
    }
    
 
    
    //number sec in table
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    //number of row in table
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return DBClient.products.count;
    }
    
    // display name in eath row
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell();
        
        cell.textLabel?.text = DBClient.products[indexPath.row].name;
        cell.imageView?.image = DBClient.products[indexPath.row].img;
        
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
