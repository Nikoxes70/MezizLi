//
//  Prodcut.swift
//  Maziz li
//
//  Created by Jonathan Birger on 03/03/2016.
//  Copyright © 2016 itzik nehemya. All rights reserved.
//

import Foundation
import UIKit
public class  Product {
    
   public var name:String;
   public var description:String;
   public var category:String;
   public var voteUp:Int;
   public var voteDown:Int;
   public var date:Double;
   public var UPC:String;
   public var user:String;
   public var img:UIImage?;
    
    public init(itemName:String,itemDescription:String,itemCategory:String,itemVoteUp:Int,itemVoteDown:Int,currentDate:Double?,UPC:String?,user:String,img:UIImage?){
        
        self.name = itemName;
        self.description = itemDescription;
        self.category = itemCategory;
        if img != nil{
            self.img = img!;
        }else{
            self.img!.valueForKey("default_product_img.jpg");
        }
        self.voteUp=itemVoteUp;
        self.voteDown=itemVoteDown;
        self.date = currentDate!;
        self.UPC = UPC != nil ? UPC! : "";
        self.user = user;
    }
    
}



