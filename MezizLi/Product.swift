//
//  Prodcut.swift
//  Maziz li
//
//  Created by Jonathan Birger on 03/03/2016.
//  Copyright © 2016 itzik nehemya. All rights reserved.
//

import Foundation
import UIKit
class  Product {
    
    var name:String;
    var description:String;
    var category:String;
    var voteUp:Int;
    var voteDown:Int;
    var date:Double;
    var UPC:String;
    var user:String;
    var img:UIImage?;
    
    init(itemName:String,itemDescription:String,itemCategory:String,itemVoteUp:Int,itemVoteDown:Int,date:Double,UPC:String?,user:String,img:UIImage?){
        
        self.name = itemName;
        self.description = itemDescription;
        self.category = itemCategory;
        if img != nil{
            self.img = img!;
        }else{
            self.img!.valueForKey("default_product_img.jpg");
        }
        self.voteUp=0;
        self.voteDown=0;
        self.date = NSDate().timeIntervalSince1970;
        self.UPC = UPC != nil ? UPC! : "";
        self.user = user;
    }

}



