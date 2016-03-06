//
//  UploadProduct2DB.swift
//  Maziz li
//
//  Created by Jonathan Birger on 06/03/2016.
//  Copyright © 2016 itzik nehemya. All rights reserved.
//

import Foundation
import UIKit

class UploadProduct2DB: UIViewController {
    func uploadImageOne(){
//        var imageData = UIImagePNGRepresentation(imageView.image)
//        
//        if imageData != nil{
//            var request = NSMutableURLRequest(URL: NSURL(string:"Enter Your URL")!)
//            var session = NSURLSession.sharedSession()
//            
//            request.HTTPMethod = "POST"
//            
//            var boundary = NSString(format: "---------------------------14737809831466499882746641449")
//            var contentType = NSString(format: "multipart/form-data; boundary=%@",boundary)
//            //  println("Content Type \(contentType)")
//            request.addValue(contentType, forHTTPHeaderField: "Content-Type")
//            
//            var body = NSMutableData.alloc()
//            
//            // Title
//            body.appendData(NSString(format: "\r\n--%@\r\n",boundary).dataUsingEncoding(NSUTF8StringEncoding)!)
//            body.appendData(NSString(format:"Content-Disposition: form-data; name=\"title\"\r\n\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
//            body.appendData("Hello World".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!)
//            
//            // Image
//            body.appendData(NSString(format: "\r\n--%@\r\n", boundary).dataUsingEncoding(NSUTF8StringEncoding)!)
//            body.appendData(NSString(format:"Content-Disposition: form-data; name=\"profile_img\"; filename=\"img.jpg\"\\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
//            body.appendData(NSString(format: "Content-Type: application/octet-stream\r\n\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
//            body.appendData(imageData)
//            body.appendData(NSString(format: "\r\n--%@\r\n", boundary).dataUsingEncoding(NSUTF8StringEncoding)!)
//            
//            
//            
//            request.HTTPBody = body
//            
//            
//            var returnData = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
//            
//            var returnString = NSString(data: returnData!, encoding: NSUTF8StringEncoding)
//            
//            println("returnString \(returnString)")
//            
//        }
//    
//    
//    //add new user to server
//    private func addProduct(itemName:String, itemDescription:String, itemCategory:String,Date:Double, UPC:String, user:String,img:UIImage)
//    {
//        let imgData = img as! NSData;
//        let requset = NSMutableURLRequest(URL: NSURL(string:"http://www.itzikne.5gbfree.com/DBProducts/postDataPhp.php")!);
//        requset.HTTPMethod="POST";
//        requset.HTTPBody="name=\(itemName)&description=\(itemDescription)&category=\(itemCategory)&createTime=\(Date)&barcode=\(UPC)&owner=\(user)&image=\(imgData)".dataUsingEncoding(NSUTF8StringEncoding);
//        NSURLSession.sharedSession().dataTaskWithRequest(requset, completionHandler: {(d,r,e)in
//            
//            print(String(data: d!, encoding: NSUTF8StringEncoding)!);
//            
//        }).resume();
//    }
//    
//  
//
    
    
    
    }

}