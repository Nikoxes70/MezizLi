//
//  Prodcut.swift
//  Maziz li
//
//  Created by Jonathan Birger on 03/03/2016.
//  Copyright © 2016 itzik nehemya. All rights reserved.
//

import Foundation
import UIKit

let productID = "id"
let productName = "name"
let productCategory = "category"
let productDescription = "description"
let productVoteUp = "voteUp"
let productVoteDown = "voteDown"
let productUser = "user"
let productDate = "date"
let productUPC = "UPC"
let productIMG = "img"
let productVoted = "voted"

public class  Product:NSObject{
    
    var name:String;
    var pDescription:String;
    var category:String;
    var voteUp:Int;
    var voteDown:Int;
    var date:Double;
    var UPC:String;
    var user:String;
    var img:UIImage?;
    var id:Int;
    var voted:String;
    override public var description:String{
        return "Product: \(name)"
    }
    init(itemName:String,itemDescription:String,itemCategory:String,itemVoteUp:Int,itemVoteDown:Int,currentDate:Double?,UPC:String?,user:String,img:UIImage?,id:Int,Voted:String){
        
        self.id = id
        self.name = itemName;
        self.category = itemCategory;
        self.voteUp=itemVoteUp;
        self.voteDown=itemVoteDown;
        self.date = currentDate!;
        self.UPC = UPC != nil ? UPC! : "";
        self.user = user;
        self.img = img
        self.pDescription = itemDescription
        self.voted=Voted;
    }

    public func encodeWithCoder(aCoder:NSCoder){

        aCoder.encodeObject(self.name, forKey: productName)
        aCoder.encodeObject(self.pDescription, forKey: productDescription)
        aCoder.encodeObject(self.category, forKey: productCategory)
        aCoder.encodeInteger(self.voteUp, forKey: productVoteUp)
        aCoder.encodeInteger(self.voteDown, forKey: productVoteDown)
        aCoder.encodeDouble(self.date, forKey: productDate)
        aCoder.encodeObject(self.UPC, forKey: productUPC)
        aCoder.encodeObject(self.user, forKey: productUser)
        aCoder.encodeObject(self.img, forKey: productIMG)
        aCoder.encodeInteger(self.id, forKey: productID)
        aCoder.encodeObject(self.voted, forKey: productVoted)
    }
    public required init(coder aDecoder:NSCoder) {
        
        self.pDescription = (aDecoder.decodeObjectForKey(productDescription) as? String)!
        self.name = (aDecoder.decodeObjectForKey(productName) as? String)!
        self.category = (aDecoder.decodeObjectForKey(productCategory) as? String)!
        self.img = aDecoder.decodeObjectForKey(productIMG) as? UIImage
        self.voteUp = aDecoder.decodeIntegerForKey(productVoteUp)
        self.voteDown = aDecoder.decodeIntegerForKey(productVoteDown)
        self.date = aDecoder.decodeDoubleForKey(productDate)
        self.UPC = (aDecoder.decodeObjectForKey(productUPC) as? String)!
        self.user = (aDecoder.decodeObjectForKey(productUser) as? String)!
        self.id = aDecoder.decodeIntegerForKey(productID)
        self.voted = (aDecoder.decodeObjectForKey(productVoted) as? String)!
    }
    
}



