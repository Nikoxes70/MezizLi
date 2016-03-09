//
//  MazizLIViewController.swift
//  Maziz li
//
//  Created by Jonathan Birger on 06/03/2016.
//  Copyright © 2016 itzik nehemya. All rights reserved.
//

import UIKit
    
    class MazizLIVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
        
        
        let UDefaults = NSUserDefaults.standardUserDefaults();
       
        
        @IBOutlet weak var tableView: UITableView!
        var name:String = "";
        override func viewDidAppear(animated: Bool) {
            tableView.reloadData();
        }
        override func viewDidLoad() {
           tableView.reloadData();
            
        }
        @IBAction func backToMazizLi(sender:UIStoryboardSegue){

        }
        //number sec in table
        func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return 1;
        }
        
        //number of row in table
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return DBClient.myProducts.count;
        }
        
        // display name in eath row
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("MyCell") as! MyProductCTBC
            cell.mttlForCell.text = DBClient.myProducts[indexPath.row].name;
            cell.mimgForCell?.image = DBClient.myProducts[indexPath.row].img;
            //
            cell.mimgForCell.clipsToBounds=true;
            cell.mimgForCell?.layer.cornerRadius = CGFloat(55);
            //
            cell.mvoteUpTTL.text = "\(DBClient.myProducts[indexPath.row].voteUp)";
            cell.mvoteDownTTL.text = "\(DBClient.myProducts[indexPath.row].voteDown)";
            
            
            return cell;
        }
        
        //do action on click on 1 row
        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
            
            let nextScreen = storyboard?.instantiateViewControllerWithIdentifier("productINFO") as! MazizLaamInfoVC;
            
            let product=DBClient.myProducts[indexPath.row];
            
            
            nextScreen.setSelectedProduct(product.name, PvoteUp: product.voteUp, PvoteDown: product.voteDown, Pdescription: product.description,Pimg: product.img!)
            
            
            
            showViewController(nextScreen, sender: self);
            
        }
        
        
}
