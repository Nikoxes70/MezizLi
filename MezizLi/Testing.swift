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
    
}
