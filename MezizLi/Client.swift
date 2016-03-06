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
    
    func addUser(firstName:String, lastName:String, email:String, password:String, phoneNumber:Int, prob1:String, prob2:String, prob3:String){
        
        print("\(firstName),\(lastName),\(email),\(password),\(phoneNumber),\(prob1),\(prob2),\(prob3)");
        
        let request = NSMutableURLRequest(URL: NSURL(string:"http://www.itzikne.5gbfree.com/DBUsers/postDataPhp.php")!);
        
        request.HTTPMethod = "POST";
        
        request.HTTPBody = "firstName=\(firstName)&lastName=\(lastName)&email=\(email)&password=\(password)&phoneNumber=\(phoneNumber)&prob1=\(prob1)&prob2=\(prob2)&prob3=\(prob3)".dataUsingEncoding(NSUTF8StringEncoding);
        
        NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {(d,r,e)in
            if e == nil{
                print(String(data: d!, encoding: NSUTF8StringEncoding)!);
            }else{
                print("Error adding user");
            }
        }).resume()
    }
    
    
    func getDataFromServer()///->[Product]
    {
        //get data from server
        //var db:[Product]!
        
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: "http://www.itzikne.5gbfree.com/DBProducts/getDataPhp.php")!, completionHandler: {d,r,e in
            
//            AsyncTask(backgroundTask: { () ->[Product]  in
//                
//                db = self.readJSON(d!)
//                return db
//                }) { (str) -> () in
//                    
//                }.execute()
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
        //print(json);
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
       // MazizLaamVC().reload()
        //return DBClient.products
    }
    
    
    
}

