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

class UploadProduct2DB {
    
    
    func addProduct(product:Product)
        {
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
    
//
//    func addProdcut(product:Product){
//    let boundary = "AaBbCc&&D"
//        let request = NSMutableURLRequest(URL: NSURL(string:"http://www.itzikne.5gbfree.com/DBProducts/postDataPhp.php")!);
//            request.HTTPMethod = "POST"
//        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type");
//        request.HTTPBody="name=\(product.name)&description=\(product.description)&category=\(product.category)&createTime=\(product.date)&barcode=\(product.UPC)&owner=\(product.user)&img=http://m.pricez.co.il/ProductPictures/200x/\(product.UPC).jpg".dataUsingEncoding(NSUTF8StringEncoding);
//        
//      let body = NSMutableData()
//        body.appendString("--\(boundary)\r\n")
//        body.appendString("Content-Disposition: form-data; name=\"\\)\"\r\n\r\n")
//        body.appendString("\()\r\n")
//    }
    /// Create body of the multipart/form-data request
    ///
    /// - parameter parameters:   The optional dictionary containing keys and values to be passed to web service
    /// - parameter filePathKey:  The optional field name to be used when uploading files. If you supply paths, you must supply filePathKey, too.
    /// - parameter paths:        The optional array of file paths of the files to be uploaded
    /// - parameter boundary:     The multipart/form-data boundary
    ///
    /// - returns:                The NSData of the body of the request
    
//    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, paths: [String]?, boundary: String) -> NSData {
//        let body = NSMutableData()
//        
//        if parameters != nil {
//            for (key, value) in parameters! {
//                body.appendString("--\(boundary)\r\n")
//                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
//                body.appendString("\(value)\r\n")
//            }
//        }
//        
//        if paths != nil {
//            for path in paths! {
//                let url = NSURL(fileURLWithPath: path)
//                let filename = url.lastPathComponent
//                let data = NSData(contentsOfURL: url)!
//              //  let mimetype = mimeTypeForPath(path)
//                
//                body.appendString("--\(boundary)\r\n")
//                body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename!)\"\r\n")
//                body.appendString("Content-Type: \(mimetype)\r\n\r\n")
//                body.appendData(data)
//                body.appendString("\r\n")
//            }
//        }
//        
//        body.appendString("--\(boundary)--\r\n")
//        return body
//    }
//    
//    func mimeTypeForPath(p: Product) -> String {
//      //  let url = NSURL(fileURLWithPath: path)
//      //  let pathExtension = url.pathExtension
//        
//        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, p.img as NSString, nil)?.takeRetainedValue() {
//            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
//                return mimetype as String
//            }
//        }
//        return "application/octet-stream";
//    }

    
//    func addProduct(product:Product)
//    {
//        let request = NSMutableURLRequest(URL: NSURL(string:"http://www.itzikne.5gbfree.com/DBProducts/postDataPhp.php")!);
//        request.HTTPMethod = "POST"
//        
//        // params
//        
//        request.HTTPBody="name=\(product.name)&description=\(product.description)&category=\(product.category)&createTime=\(product.date)&barcode=\(product.UPC)&owner=\(product.user)&img=http://m.pricez.co.il/ProductPictures/200x/\(product.UPC).jpg".dataUsingEncoding(NSUTF8StringEncoding);
//        
//        NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {(d,r,e)in
//            if e == nil {
//                print(String(data: d!, encoding: NSUTF8StringEncoding)!);
//            }else{print("error")}
//        }).resume();
//        
//        
//        
//    }
//    
    
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



