//
//  Testing.swift
//  MezizLi
//
//  Created by Nikolai Volodin on 13/03/2016.
//  Copyright © 2016 Nikolai Volodin. All rights reserved.
//

import Foundation
import UIKit

class Testing{
//    func fetchPhotoForPublication(product: Product , completion: (image: UIImage?)->Void) {
//        
//        var photo: UIImage? = nil
//        
//        let transferManager = AWSS3TransferManager.defaultS3TransferManager()
//        
//        let downloadedFilePath = FCModel.sharedInstance.photosDirectoryUrl.URLByAppendingPathComponent("/\(publication.photoUrl)")
//        let downloadedFileUrl = NSURL.fileURLWithPath(downloadedFilePath.path!)
//        
//        let downloadRequest = AWSS3TransferManagerDownloadRequest()
//        downloadRequest.bucket = self.bucketNameForBundle()//"foodcollector"
//        downloadRequest.key = publication.photoUrl
//        downloadRequest.downloadingFileURL = downloadedFileUrl
//        
//        transferManager.download(downloadRequest).continueWithExecutor(AWSExecutor.mainThreadExecutor(), withBlock: { (task: AWSTask!) -> AnyObject! in
//            
//            
//            if task.error != nil {
//                print(task.error)
//                completion(image: photo)
//            }
//            
//            if task.result != nil {
//                
//                //let downloadOutput = task.result as! AWSS3TransferManagerDownloadOutput
//                photo = UIImage(contentsOfFile: downloadedFilePath.path!)
//                publication.photoData.didTryToDonwloadImage = true
//                if let publicationPhoto = photo {
//                    publication.photoData.photo = publicationPhoto
//                }
//                completion(image: photo)
//            }
//            
//            
//            return nil
//        })
//      }
    func documentsDirectory() -> String {
        
        var doucuments = ""
        let dirs : [String]? = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)
        if  dirs != nil {
            doucuments = dirs![0]
        }
        return doucuments
    }
    ////
    ////
    

    /////????//////
//    let publicationsFilePath =
    func savePublications() {
        let db = DBClient.getDBClient()
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            let publicationsFilePath = self.documentsDirectory().stringByAppendingString("/publications")
            NSKeyedArchiver.archiveRootObject(db.products, toFile: publicationsFilePath)
        }
    }
    
    func loadPublications() {
        let db = DBClient.getDBClient()
        let publicationsFilePath = self.documentsDirectory().stringByAppendingString("/publications")
 
        print("load publications from path: \(publicationsFilePath)")
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            
            if NSFileManager.defaultManager().fileExistsAtPath(publicationsFilePath){
                let array = NSKeyedUnarchiver.unarchiveObjectWithFile(publicationsFilePath) as! [Product]
                db.products = array
            }
        }
    }
    func preparePhotosDirectory() -> NSURL {
        
        let fm = NSFileManager.defaultManager()
        let appSupportDirs = fm.URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask)
        let photosDirectoryUrl = appSupportDirs[0].URLByAppendingPathComponent("Images")
        
        
        if !photosDirectoryUrl.checkResourceIsReachableAndReturnError(nil) {
            do {
                try fm.createDirectoryAtURL(photosDirectoryUrl, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error)
            }
        }
        
        print(photosDirectoryUrl.path)
        return photosDirectoryUrl
    }
}
