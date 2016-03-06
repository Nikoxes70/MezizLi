//
//  AddProdViewController.swift
//  Maziz li
//
//  Created by Jonathan Birger on 03/03/2016.
//  Copyright © 2016 itzik nehemya. All rights reserved.
//

import UIKit
import AVFoundation;
import AVKit
import AssetsLibrary;
import Photos;

class AddProdVC : UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    var imgPicker = UIImagePickerController();
    @IBAction func createProdcut(sender: UIButton) {
    }
    @IBOutlet weak var prodName: UITextField!
    @IBOutlet var desricption: UITextView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var imgView: UIImageView!
    var imgPath:String="";
    @IBOutlet weak var labelUPC: UILabel!
    var getUPC:String?;
    
    
    override func viewDidLoad() {
        imgPicker.delegate=self;
        pickerView.delegate=self;
    }
    func viewDidAppear() {
    
    }
    
    
    var categories=["מזון","פארם","תינוקות","טיפוח","תקשורת","ביגוד","אחר"];
    
    var myCategory:String="";
    //how many components
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row];
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        myCategory=categories[row];
    }
    
    private func UPCsetter(upc:String){
        labelUPC.text="fff\(upc)";
        print(upc);
        
    }
    
    @IBAction func picImg(sender: UIButton) {
        imgPicker.sourceType = .Camera;
        showViewController(imgPicker, sender: self);
    }
    func imagePickerController(picker: UIImagePickerController,  didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        // let imagename:String="Mazizli_\(round(NSDate().timeIntervalSince1970))";
        
        
        dismissViewControllerAnimated(true, completion: {
            PHPhotoLibrary.sharedPhotoLibrary().performChanges({() -> Void in
                PHAssetChangeRequest.creationRequestForAssetFromImage(image)
                }, completionHandler:{ success, error in
                    NSLog("Finished updating asset. %@", (success ? "Success." : error!))
            })
            
            self.imgView.contentMode = .ScaleToFill;
            self.imgView.image=image;
        })
        
        
    }
    
    
    @IBAction func backFromUPCScanner(segue:UIStoryboardSegue){
        if let s = segue.sourceViewController as? UPCImageVC{
            if let upc = s.upc{
                UPCsetter(upc);
            }
        }
    }
    @IBAction func createAndSendProd(sender: AnyObject) {
        
        //let product = Products(itemName: prodName.text!, itemDescription: desricption.text, itemCategory: myCategory)
//        product.img=imgView.image;
//        product.UPC = self.getUPC!
//        product.user="";
        
    }

}
