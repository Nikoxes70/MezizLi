//
//  MazizLaumViewController.swift
//  Maziz li
//
//  Created by itzik nehemya on 02/03/2016.
//  Copyright © 2016 itzik nehemya. All rights reserved.
//

import UIKit

class MazizLaamVC: UIViewController,UITableViewDataSource,UITableViewDelegate,SWRevealViewControllerDelegate{
    var user:String = ""
    @IBOutlet weak var mainTTL: UIImageView!
    var refreshControl: UIRefreshControl!
    var DBCLoadToken: dispatch_once_t = 0
    let UDefaults = NSUserDefaults.standardUserDefaults();
    let DBC = DBClient.getDBClient()
//    self.revealViewController.delegate = self;
    @IBOutlet weak var tableView: UITableView!
    //@IBOutlet weak var sideMenuBtn: UIButton!
    @IBOutlet weak var sideMEnuBtn: UIBarButtonItem!
    
    override func viewDidAppear(animated: Bool) {
        
       // UDefaults.removeObjectForKey("LoggedUser")
        
                    dispatch_once(&DBCLoadToken, {//calls once on appStart
                        
        if let u = self.UDefaults.objectForKey("LoggedUser") as? String{
            
        self.user = u
            
        //DBDocs().loadPublications(self.tableView)
        //Client().getDataFromServer(u, tv: self.tableView)
            Client().reloadDataFromServer(u, tv: self.tableView)
            }else{
            self.performSegueWithIdentifier("sign", sender: self)
        }
    })
                tableView.reloadData()
    }
    override func viewWillAppear(animated: Bool) {
        mainTTL.layer.zPosition = 2
    }
    
    override func viewDidLoad() {
        
        sideMEnuBtn.target = self.revealViewController()
        sideMEnuBtn.action = Selector("rightRevealToggle:")
        
        //self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())

        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(self.refreshControl) // not required when us
        
        if self.revealViewController() != nil {
            
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
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
        cell.imgForCell.clipsToBounds=true;
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
        
        nextScreen.setSelectedProduct(product.name, PvoteUp: product.voteUp, PvoteDown: product.voteDown, Pdescription: product.pDescription,Pimg: product.img!,id: product.id,Voted: product.voted);
       
        
        
        showViewController(nextScreen, sender: self);
        
    }
    func updateData(timer:NSTimer){
        print("reloaded")
    }
    func refresh(sender:AnyObject)
    {
        //Client().reloadDataFromServer(user, tv: self.tableView)
        self.tableView.reloadData()
        //print(DBC.products[0].user)
       // DBDocs().savePublications()
        // Code to refresh table view
        //print("table refreshed!!")
       // Client().getDataFromServer(user, tv: self.tableView)
        self.refreshControl.endRefreshing()
    }

}
