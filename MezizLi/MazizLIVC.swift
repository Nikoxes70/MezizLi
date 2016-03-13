//
//  MazizLIViewController.swift
//  Maziz li
//
//  Created by Jonathan Birger on 06/03/2016.
//  Copyright © 2016 itzik nehemya. All rights reserved.
//

import UIKit

    class MazizLIVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
        let DBC = DBClient.getDBClient()
        
        @IBOutlet weak var sideMenuBTN: UIBarButtonItem!
        
        let UDefaults = NSUserDefaults.standardUserDefaults();
       
        
        @IBOutlet weak var tableView: UITableView!
        var name:String = "";
        override func viewDidAppear(animated: Bool) {
            tableView.reloadData();
        }
        override func viewDidLoad() {
            
            tableView.reloadData();
            
            sideMenuBTN.target = self.revealViewController()
            sideMenuBTN.action = Selector("revealToggle:")
            
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
        @IBAction func backToMazizLi(sender:UIStoryboardSegue){

        }
        //number sec in table
        func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return 1;
        }
        
        //number of row in table
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return DBC.myProducts.count
        }
        
        // display name in eath row
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("MyCell") as! MyProductCTBC
            cell.mttlForCell.text = DBC.myProducts[indexPath.row].name;
            cell.mimgForCell?.image = DBC.myProducts[indexPath.row].img;
            //
            cell.mimgForCell.clipsToBounds=true;
            cell.mimgForCell?.layer.cornerRadius = CGFloat(55);
            //
            cell.mvoteUpTTL.text = "\(DBC.myProducts[indexPath.row].voteUp)";
            cell.mvoteDownTTL.text = "\(DBC.myProducts[indexPath.row].voteDown)";
            
            
            return cell;
        }
        
        //do action on click on 1 row
        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
            
            let nextScreen = self.storyboard?.instantiateViewControllerWithIdentifier("upDateInfoProduct") as! UpDateProductVC;
            
            let product=DBC.myProducts[indexPath.row];
            let bar=DBC.products[indexPath.row];
            
            nextScreen.setUpDateProduct(product.name, Pdescription: product.description, Pimg: product.img!, id: product.id, Pbarcode: bar.UPC)
            
            self.showViewController(nextScreen, sender: self);
            
        }
        
        func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
            
            //Delete action
            let delete = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "מחק", handler:{
                (action,indexPath)->Void in
                //delete in server && delete from table view
                let MYproduct = self.DBC.myProducts[indexPath.row];
                
                for(var i=0; i < self.DBC.products.count; i++){
                    if self.DBC.products[i].id == MYproduct.id{
                        self.DBC.products.removeAtIndex(i)
                        print("delete");
                    }
                }
                Client().deleteProductInServer(MYproduct.id)//delete from server
                self.DBC.myProducts.removeAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)})
            
            //edit Action
            let edit = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "ערוך", handler: { (action, indexPath) -> Void in
                
                let nextScreen = self.storyboard?.instantiateViewControllerWithIdentifier("upDateInfoProduct") as! UpDateProductVC;
                
                let product=self.DBC.myProducts[indexPath.row];
                let bar=self.DBC.products[indexPath.row];
                
                nextScreen.setUpDateProduct(product.name, Pdescription: product.description, Pimg: product.img!, id: product.id, Pbarcode: bar.UPC)
                
                self.showViewController(nextScreen, sender: self);
            });
            edit.backgroundColor = UIColor.blueColor();
            return [delete,edit]
        }
 
        
        
}
