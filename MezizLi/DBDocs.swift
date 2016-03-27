//
//  DBDocs.swift
//  MezizLi
//
//  Created by Nikolai Volodin on 14/03/2016.
//  Copyright © 2016 Nikolai Volodin. All rights reserved.
//

import Foundation
public class DBDocs{
    
    let db = DBClient.getDBClient()
    
    public func documentsDirectory() -> String {
        
        var doucuments = ""
        let dirs : [String]? = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)
        if  dirs != nil {
            doucuments = dirs![0]
        }
        return doucuments
    }
    public func savePublications() {
        
        let productsFilePath = self.documentsDirectory().stringByAppendingString("/products")
        let myproductsFilePath = self.documentsDirectory().stringByAppendingString("/myProducts")
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
        NSKeyedArchiver.archiveRootObject(self.db.products, toFile: productsFilePath)
        NSKeyedArchiver.archiveRootObject(self.db.myProducts, toFile: myproductsFilePath)
        print("arrays saved!")
            
            
        }
 
    
    }
    public func loadPublications() {
        
        let productsFilePath = self.documentsDirectory().stringByAppendingString("/products")
        let myproductsFilePath = self.documentsDirectory().stringByAppendingString("/myProducts")
       
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            
            if NSFileManager.defaultManager().fileExistsAtPath(productsFilePath){
                let array = NSKeyedUnarchiver.unarchiveObjectWithFile(productsFilePath) as! [Product]
                self.db.products = array
            }else{
                print("loadError")
            }
            if NSFileManager.defaultManager().fileExistsAtPath(myproductsFilePath){
                let array = NSKeyedUnarchiver.unarchiveObjectWithFile(myproductsFilePath) as! [Product]
                self.db.myProducts = array
            }else{
                print("loadError")
            }
        }
    }
    public func loadPublications(tv:UITableView) {
        
        AsyncTask(backgroundTask: {()in
            let productsFilePath = self.documentsDirectory().stringByAppendingString("/products")
            let myProductsFilePath = self.documentsDirectory().stringByAppendingString("/myProducts")
            
            
                
                if NSFileManager.defaultManager().fileExistsAtPath(productsFilePath){
                    let array = NSKeyedUnarchiver.unarchiveObjectWithFile(productsFilePath) as! [Product]
                    self.db.products = array
                }else{
                    print("p loadError")
                }
                if NSFileManager.defaultManager().fileExistsAtPath(myProductsFilePath){
                    let myArray = NSKeyedUnarchiver.unarchiveObjectWithFile(myProductsFilePath) as! [Product]
                    self.db.myProducts = myArray
                }else{
                    print("myP loadError")
                }
        
            }, afterTask: {()in
                print("fini")
                tv.reloadData()
        }).execute()

    }
}