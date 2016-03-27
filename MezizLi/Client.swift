//
//  Client.swift
//  Maziz li
//
//  Created by Nikolai Volodin on 04/03/2016.
//  Copyright © 2016 itzik nehemya. All rights reserved.
//

import Foundation
import UIKit
class Client{
   let DBC = DBClient.getDBClient()
    
    func addUser(firstName:String, lastName:String, email:String, phoneNumber:String)->String{
        
        var result:String = "none"
        print("\(firstName),\(lastName),\(email),\(phoneNumber)");
        
        let request = NSMutableURLRequest(URL: NSURL(string:"http://www.itzikne.5gbfree.com/DBUsers/postDataPhp.php")!);
        
        request.HTTPMethod = "POST";
        
        request.HTTPBody = "firstName=\(firstName)&lastName=\(lastName)&email=\(email)&phoneNumber=\(phoneNumber)".dataUsingEncoding(NSUTF8StringEncoding);
        
        
        AsyncTask(backgroundTask: {() in
            
            NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {(d,r,e)in
                if e == nil{
                    print(String(data: d!, encoding: NSUTF8StringEncoding)!);
                    result = String(data: d!, encoding: NSUTF8StringEncoding)!
                    
                }else{
                    result = "Error adding user please try again later";
                }
            }).resume()
            
            
            }, afterTask: {()in
                
        }).execute()
        print(DBC.products.count)
        return result
        
    }
    
    func getDataFromServer(user:String,tv:UITableView?=nil)
    {
        
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: "http://www.itzikne.5gbfree.com/DBProducts/getDataPhp.php")!, completionHandler: {d,r,e in
            
            self.readJSON(d!,user: user,tv: tv)
            
        }).resume();
        
    }
    //read from the server with 'd'->data from server,'user'->currentrly logged user,->'tv' tableView where reloadData to
    private func readJSON(d:NSData,user:String,tv:UITableView?){
        
        let json:[[String:AnyObject]] = initJson(d)
        
        for i in json
        {
            AsyncTask(backgroundTask: {(i)in
                
                self.addProdToDBC(i, user: user)
                
                }, afterTask: {()in
                    
                    if  MazizLaamVC().isViewLoaded() && MazizLaamVC().view.window != nil{
                        print("MZVC loaded")
                    }
                    
                    tv != nil ? tv!.reloadData() : ()
                    
            }).execute(i)
        }
    }
    
    func deleteProductInServer(id:Int){
        let request = NSMutableURLRequest(URL: NSURL(string:"http://www.itzikne.5gbfree.com/DBProducts/deleteProduct.php")!);
        
        request.HTTPMethod = "POST";
        
        request.HTTPBody = "id=\(id)".dataUsingEncoding(NSUTF8StringEncoding);
        print(id)
        NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {(d,r,e)in
            if e == nil{
                print(String(data: d!, encoding: NSUTF8StringEncoding)!);
                print("deleted from server")
            }
        }).resume()
    }
    
    func updateingProduct(id:Int,name:String,description:String,category:String){
        
        let request = NSMutableURLRequest(URL: NSURL(string:"http://www.itzikne.5gbfree.com/DBProducts/updateProduct.php")!);
        
        request.HTTPMethod = "POST";
        
        request.HTTPBody = "name=\(name)&id=\(id)&category=\(category)&description=\(description)".dataUsingEncoding(NSUTF8StringEncoding);
        
        NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {(d,r,e)in
            
            print(String(data: d!, encoding: NSUTF8StringEncoding)!);
            
        }).resume()
    }
    
    func reloadDataFromServer(user:String,tv:UITableView? = nil){
        
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: "http://www.itzikne.5gbfree.com/DBProducts/getDataPhp.php")!, completionHandler: {d,r,e in
            if e == nil{
                
                tv != nil ? self.reload(d!,user: user,tv: tv) : self.reload(d!,user:user)
            }else{
                print("error reloading data from selver")
            }
            
            
        }).resume();
        
    }
    func reload(d:NSData,user:String,tv:UITableView? = nil){
        
        let json = initJson(d)
        
        for i in json
        {
            
            AsyncTask(backgroundTask: {(i)in

                self.addProdToDBC(i, user: user)
//                let id = (i["id"]! as! String)
//                
//                for (j,p) in self.DBC.products.enumerate().reverse(){
//                    
//                    //print("from:\(id) :::: p:\(p.id)/")
//                    
//                    if self.checkDoesProductexistInDBC(id){ // If product exist
//                        
//                        self.checkProductForUpdates(p, i: i)// -> check product for updates
//                        
//                    }else{// The product doesnt exist
//                        
//                        self.addProdToDBC(i, user: user)// -> add them to DBC
//                        
//                    }
//                    if !self.checkIfProductExistInDBD(p, json: json){
//                        self.DBC.products.removeAtIndex(j)
//                        print("exist")
//                    }
//                }
                
                }, afterTask: {()in
                    
                    if  MazizLaamVC().isViewLoaded() && MazizLaamVC().view.window != nil{//TODO:check if this shit works
                        print("MZVC loaded")
                    }
                    
                    tv != nil ? tv!.reloadData() : ()
                   
                    
            }).execute(i)
        }
         print("relaoded data")
       
    }
    
//    func checkDoesProductexistInDBC(id:String)->Bool{
//        
//        for p in self.DBC.products{
//            if Int(id) == p.id{
//                return false
//            }
//        }
//        
//        return true
//    }
//    func checkIfProductExistInDBD(p:Product,json:[[String:AnyObject]])->Bool{
//        for i in json{
//            let id = (i["id"]! as! String)
//            
//            if p.id != Int(id){
//                print("c:\(id) ... p:\(p.id)")
//                return true
//            }
//        }
//        return false
//    }
//    func checkProductForUpdates(p:Product,i:[String:AnyObject]){
//        
//        let voteUp = (i["voteUp"]! as! String);
//        let voteDown = (i["voteDown"]! as! String);
//        let voted = (i["voted"]! as! String);
//        
//        if p.voteUp != Int(voteUp) || p.voteDown != Int(voteDown){ //if some product value have changed -> update them
//            p.voteUp = Int(voteUp)!
//            p.voteDown = Int(voteDown)!
//            p.voted = voted
//        }
//    }
   
    
    func addProdToDBC(i:[String:AnyObject],user:String){
        
        var image : UIImage?
        let category = (i["category"]! as! String);
        let name = (i["name"]! as! String);
        let description = (i["description"]! as! String);
        let voteUp = (i["voteUp"]! as! String);
        let voteDown = (i["voteDown"]! as! String);
        let img = (i["img"]! as! String);
        let date = 0.0
        let userFromServer = (i["owner"]! as! String)
        let UPC = ""
        let id = (i["id"]! as! String);
        let voted = (i["voted"]! as! String);
        
        if let url = NSURL(string: img){
            if let data = NSData(contentsOfURL: url){
                image = UIImage(data: data)!
            }
        }else{
            print("error load image")
        }
        
        let newProduct = Product(itemName: name, itemDescription: description, itemCategory: category, itemVoteUp: Int(voteUp)!, itemVoteDown: Int(voteDown)!, currentDate: date, UPC: UPC, user: userFromServer, img: image,id:Int(id)!,Voted: voted);
        
        self.DBC.products.append(newProduct)
        
        if user == userFromServer{
            self.DBC.myProducts.append(newProduct)
        }
        
    }
    
    
    func initJson(d:NSData)->[[String:AnyObject]]{
        
        var json:[[String:AnyObject]];
        
        do{
            json = (try NSJSONSerialization.JSONObjectWithData(d, options: [])) as! Array
        }catch{
            json = [];
        }
        return json
    }
}

