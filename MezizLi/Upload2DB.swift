//
//  UploadProduct2DB.swift
//  Maziz li
//
//  Created by Jonathan Birger on 06/03/2016.
//  Copyright © 2016 itzik nehemya. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices

extension NSMutableData {
    
    /// Append string to NSMutableData
    ///
    /// Rather than littering my code with calls to `dataUsingEncoding` to convert strings to NSData, and then add that data to the NSMutableData, this wraps it in a nice convenient little extension to NSMutableData. This converts using UTF-8.
    ///
    /// - parameter string:       The string to be added to the `NSMutableData`.
    
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
    }
}

class Upload2DB {
    
    var fileName:String=""
    func myImageUploadRequest(product:Product)
{
    let myUrl = NSURL(string: "http://www.itzikne.5gbfree.com/addProductImg.php");
    let request = NSMutableURLRequest(URL:myUrl!);
    request.HTTPMethod = "POST";
    
    let param = [
        "name": product.name,
        "description": product.description,
        "category": product.category,
        "createTime":"\(product.date)",
        "barcode":product.UPC,
        "owner":product.user
    ]
    print(param);
    fileName="\(product.user)_\(product.date).jpg";
    
    let boundary = generateBoundaryString()
    
    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    
    let smallImg=resizeimage(product.img!);
   // smallImg = UIImage(named: filename)
    let imageData = UIImageJPEGRepresentation(smallImg,1)
    
    if(imageData==nil)  { return; }
    
    request.HTTPBody = createBodyWithParameters(param, filePathKey: "file", imageDataKey: imageData!, boundary: boundary)
    
    
    
   // myActivityIndicator.startAnimating();
    
    let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
        data, response, error in
        
        if error != nil {
            print("error=\(error)")
            return
        }
        
        // You can print out response object
        print("******* response = \(response)")
        
        // Print out reponse body
        let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
        print("****** response data = \(responseString!)")
        
      //  var err: NSError?
        do {
            if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                print(jsonResult)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        
        
        dispatch_async(dispatch_get_main_queue(),{
            //self.myActivityIndicator.stopAnimating()
            product.img = nil;
        });
        
    }
    
    task.resume()
    
}


func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
    let body = NSMutableData();
    
    if parameters != nil {
        for (key, value) in parameters! {
            body.appendString("--\(boundary)\r\n")
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString("\(value)\r\n")
        }
    }
    
    let filename = fileName;
    
    let mimetype = "image/jpg"
    
    body.appendString("--\(boundary)\r\n")
    body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
    body.appendString("Content-Type: \(mimetype)\r\n\r\n")
    body.appendData(imageDataKey)
    body.appendString("\r\n")
    
    
    
    body.appendString("--\(boundary)--\r\n")
    
    return body
}




func generateBoundaryString() -> String {
    return "Boundary-\(NSUUID().UUIDString)"
}



}





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
    

    
    




