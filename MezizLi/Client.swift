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
    var isEndedLoadUpData = true
    
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
    private func readJSON(d:NSData,user:String,tv:UITableView?)
    {
        var json:[[String:AnyObject]];
        do{
            json = (try NSJSONSerialization.JSONObjectWithData(d, options: [])) as! Array
        }catch{
            json = [];
        }
        
        for i in json
        {
            isEndedLoadUpData = false
            AsyncTask(backgroundTask: {(i)in
                
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
                    
                }
                
                let newProduct = Product(itemName: name, itemDescription: description, itemCategory: category, itemVoteUp: Int(voteUp)!, itemVoteDown: Int(voteDown)!, currentDate: date, UPC: UPC, user: userFromServer, img: image,id:Int(id)!,Voted: voted);
                
                self.DBC.products.append(newProduct)
               
                    if user == userFromServer{
                        self.DBC.myProducts.append(newProduct)
                    }
                
                }, afterTask: {()in
                    
                    if  MazizLaamVC().isViewLoaded() && MazizLaamVC().view.window != nil{
                        print("MZVC loaded")
                    }
                    
                    tv != nil ? tv!.reloadData() : ()
                    
            }).execute(i)
        }
        isEndedLoadUpData = true
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
    
//    func reloadDataFromServer(user:String,tv:UITableView? = nil){
//        
//        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: "http://www.itzikne.5gbfree.com/DBProducts/getDataPhp.php")!, completionHandler: {d,r,e in
//            
//            //self.readJSON(d!,user: user,tv: tv)
//            
//        }).resume();
//
//    }
    
}

