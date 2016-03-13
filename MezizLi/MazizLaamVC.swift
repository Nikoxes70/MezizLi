//
//  MazizLaumViewController.swift
//  Maziz li
//
//  Created by itzik nehemya on 02/03/2016.
//  Copyright © 2016 itzik nehemya. All rights reserved.
//

import UIKit

class MazizLaamVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var timer : NSTimer?
    var DBCLoadToken: dispatch_once_t = 0
    let UDefaults = NSUserDefaults.standardUserDefaults();
    let DBC = DBClient.getDBClient()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidAppear(animated: Bool) {
       // UDefaults.removeObjectForKey("LoggedUser")
                    dispatch_once(&DBCLoadToken, {
        if let _ = self.UDefaults.objectForKey("LoggedUser") as? String{
            //Client().getDataFromServer(user, tv: self.tableView) //calls once on appStart
            }else{
            self.performSegueWithIdentifier("sign", sender: self)
        }
    })
        
        timer = NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: "updateData:", userInfo: nil, repeats: true)


    }
    @IBAction func backToMaziz(sender:UIStoryboardSegue){
        
    }
    
    //number sec in table
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    //number of row in table
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //DBClient.products = ProductSorter.sortProductByVotes(DBClient.products)
        return DBC.products.count
    }
    
    // display name in eath row
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! ProductCTBC
        
        cell.ttlForCell.text = DBC.products[indexPath.row].name;
        cell.imgForCell?.image = DBC.products[indexPath.row].img;
        //

        cell.imgForCell.clipsToBounds=true;
        //
        cell.voteUpTTL.text = "\(DBC.products[indexPath.row].voteUp)";
        cell.voteDownTTL.text = "\(DBC.products[indexPath.row].voteDown)";
     
        
        return cell;
    }
    //
    private func izikColor(indexPath:NSIndexPath){
        tableView.cellForRowAtIndexPath(indexPath)?.contentView.backgroundColor=UIColor.whiteColor();
    }
    
    //
    func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        izikColor(indexPath);
    }
    
    
    
    //do action on click on 1 row
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        izikColor(indexPath);
        
        let nextScreen = storyboard?.instantiateViewControllerWithIdentifier("productINFO") as! MazizLaamInfoVC;
        
        let product = DBC.products[indexPath.row];
        
        nextScreen.setSelectedProduct(product.name, PvoteUp: product.voteUp, PvoteDown: product.voteDown, Pdescription: product.description,Pimg: product.img!,id: product.id,Voted: product.voted);
       
        
        
        showViewController(nextScreen, sender: self);
        
    }
    func updateData(timer:NSTimer){
        print("reloaded")
    }
    
}
