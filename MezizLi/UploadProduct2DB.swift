//
//  UploadProduct2DB.swift
//  Maziz li
//
//  Created by Jonathan Birger on 06/03/2016.
//  Copyright © 2016 itzik nehemya. All rights reserved.
//

import Foundation
import UIKit

class UploadProduct2DB {
    func addProduct(product:Product)
    {
        //            let smallImage=resizeimage(product.img!);
        //            let TWITTERFON_FORM_BOUNDARY:String = "AaB03x";
        let request = NSMutableURLRequest(URL: NSURL(string:"http://www.itzikne.5gbfree.com/DBProducts/postDataPhp.php")!);
        request.HTTPMethod = "POST"
        
        // params
        
        request.HTTPBody="name=\(product.name)&description=\(product.description)&category=\(product.category)&createTime=\(product.date)&barcode=\(product.UPC)&owner=\(product.user)&img=http://m.pricez.co.il/ProductPictures/200x/\(product.UPC).jpg".dataUsingEncoding(NSUTF8StringEncoding);
        
        NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {(d,r,e)in
            if e == nil {
                print(String(data: d!, encoding: NSUTF8StringEncoding)!);
            }else{print("error")}
        }).resume();
        
        
        
    }
    //    private func addUser(firstName:String, lastName:String, email:String, password:String, phoneNumber:Int, prob1:String, prob2:String, prob3:String)
    //    {
    //        let requset = NSMutableURLRequest(URL: NSURL(string:"http://www.itzikne.5gbfree.com/DBUsers/postDataPhp.php")!);
    //        requset.HTTPMethod="POST";
    //        requset.HTTPBody="firstName=\(firstName)&lastName=\(lastName)&email=\(email)&password=\(password)&phoneNumber=\(phoneNumber)&prob1=\(prob1)&prob2=\(prob2)&prob3=\(prob3)".dataUsingEncoding(NSUTF8StringEncoding);
    //        NSURLSession.sharedSession().dataTaskWithRequest(requset, completionHandler: {(d,r,e)in
    //
    //            print(String(data: d!, encoding: NSUTF8StringEncoding)!);
    //
    //        }).resume();
    //    }
    //
    //body.appendFormat("name=\(product.name)&description=\(product.description)&category=\(product.category)&createTime=\(product.date)&barcode=\(product.UPC)&owner=\(product.user)");
    // image upload
    //            body.appendFormat("%@\r\n",MPboundary)
    //            body.appendFormat("Content-Disposition: form-data; name=\"\(smallImage)\"; filename=\"pen111.png\"\r\n")
    //            body.appendFormat("Content-Type: image/png\r\n\r\n")
    //            let end:String = "\r\n\(endMPboundary)"
    //            let myRequestData:NSMutableData = NSMutableData();
    //            myRequestData.appendData(body.dataUsingEncoding(NSUTF8StringEncoding)!)
    //            myRequestData.appendData(data)
    //            myRequestData.appendData(end.dataUsingEncoding(NSUTF8StringEncoding)!)
    //            let content:String = "multipart/form-data; boundary=\(TWITTERFON_FORM_BOUNDARY)"
    //            request.setValue(content, forHTTPHeaderField: "Content-Type")
    //            request.setValue("\(myRequestData.length)", forHTTPHeaderField: "Content-Length")
    //            request.HTTPBody = myRequestData
    // request.setValue(content, forHTTPHeaderField: "Content-Type")
    //request.setValue("\(myRequestData.length)", forHTTPHeaderField: "Content-Length")
    
    //     print("this is my request \(request)");
    //       print("this is my body\(request.HTTPBody)")
    
    
    
    
    private func resizeimage(image: UIImage)->UIImage
    {
        var actualHeight:CGFloat = image.size.height
        var actualWidth:CGFloat = image.size.width;
        let maxHeight:CGFloat = 300.0;
        let maxWidth:CGFloat = 400.0;
        var imgRatio:CGFloat = actualWidth/actualHeight;
        let maxRatio:CGFloat = maxWidth/maxHeight;
        let compressionQuality:CGFloat = 0.5;//50 percent compression
        
        if (actualHeight > maxHeight || actualWidth > maxWidth)
        {
            if(imgRatio < maxRatio)
            {
                //adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight;
                actualWidth = imgRatio * actualWidth;
                actualHeight = maxHeight;
            }
            else if(imgRatio > maxRatio)
            {
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth;
                actualHeight = imgRatio * actualHeight;
                actualWidth = maxWidth;
            }
            else
            {
                actualHeight = maxHeight;
                actualWidth = maxWidth;
            }
        }
        
        let rect:CGRect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
        UIGraphicsBeginImageContext(rect.size);
        image.drawInRect(rect);
        let img:UIImage = UIGraphicsGetImageFromCurrentImageContext();
        let imageData:NSData = UIImageJPEGRepresentation(img, compressionQuality)!;
        UIGraphicsEndImageContext();
        
        return UIImage(data:imageData)!;
        
    }
    
    
}



