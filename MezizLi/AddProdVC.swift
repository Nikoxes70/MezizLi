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
    
    let UDefaults = NSUserDefaults.standardUserDefaults();

    var imgPicker = UIImagePickerController();
    
    @IBOutlet weak var prodName: UITextField!
    @IBOutlet var desricption: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var imgView: UIImageView!
    var imgPath:String="";
    @IBOutlet weak var labelUPC: UILabel!
    var getUPC:String?;
    var webimage:String?
    @IBOutlet weak var ERROR: UILabel!

    
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
        labelUPC.text="ברקוד:  \(upc)";
        getUPC=upc;
        let url = NSURL(string: "http://m.pricez.co.il/ProductPictures/200x/\(upc).jpg")
        if let data = NSData(contentsOfURL: url!){
            imgView.image = UIImage(data: data)
        }
        print(upc);
        
        
    }
    
    @IBAction func picImg(sender: UIButton) {
        imgPicker.sourceType = .Camera;
        showViewController(imgPicker, sender: self);
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true);
    }
    func imagePickerController(picker: UIImagePickerController,  didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        // let imagename:String="Mazizli_\(round(NSDate().timeIntervalSince1970))";
        
        dismissViewControllerAnimated(true, completion: {
            PHPhotoLibrary.sharedPhotoLibrary().performChanges({() -> Void in
                PHAssetChangeRequest.creationRequestForAssetFromImage(image)
                }, completionHandler:{ success, error in
                    NSLog("Finished updating asset. %@", (success ? "Success." : error!))
            })
            self.imgView.contentMode = .ScaleAspectFit;
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
    
    func verifyField(f:String,l:String)->Bool{
        if f.characters.count >= 1 && l.characters.count >= 1{
            return true
        }else{
            alertERROR("שם המוצר או התיאור לא חוקי")
        }
        return false
    }
    
    func alertERROR(txt:String){
       ERROR.text = txt//setting the error.txt lbl
        
        //creating first animation "FadeIn"
        UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.ERROR.alpha = 1.0
            }, completion: {
                (finished: Bool) -> Void in
                
                // create the second animation "FadeOut"
                UIView.animateWithDuration(1.0, delay: 2.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                    self.ERROR.alpha = 0.0
                    }, completion: nil)
        })
    }

    
    @IBAction func createAndSendProd(sender: AnyObject) {
        let myUPC=getUPC;
        
        let timeStemp=NSDate().timeIntervalSince1970;
        let mProdcut=Product(itemName: prodName.text!, itemDescription: desricption.text!, itemCategory: myCategory, itemVoteUp: 0, itemVoteDown: 0, currentDate:timeStemp , UPC: myUPC, user: "", img: imgView.image,id: 0,Voted:"")
        UploadProduct2DB().addProduct(mProdcut);
        
        verifyField(desricption.text!, l:prodName.text! ) ? addProduct() : ();
        
    }
    
    func addProduct(){
        
        var myProduct:Product!;
        let myUPC=self.getUPC;
        let userPhone = UDefaults.objectForKey("LoggedUser") as? String;
        let timeStemp=NSDate().timeIntervalSince1970;
        //let img = "http://m.pricez.co.il/ProductPictures/200x/\(myProduct.UPC).jpg"
        myProduct = Product(itemName: self.prodName.text!, itemDescription: self.desricption.text!, itemCategory: self.myCategory, itemVoteUp: 0, itemVoteDown: 0, currentDate:timeStemp , UPC: myUPC, user: userPhone!, img: self.imgView.image,id: 0,Voted: "");
        UploadProduct2DB().addProduct(myProduct);
       // self.performSegueWithIdentifier("MazizLi", sender: self);

//        AsyncTask(backgroundTask: {(p:Product)->Void in
//           UploadProduct2DB().addProduct(p);
//        }, afterTask: {
//            self.performSegueWithIdentifier("MazizLi", sender: self);
//        }).execute(myProduct);
        //myProduct.img = UIImage(
        
        if let url = NSURL(string: "http://m.pricez.co.il/ProductPictures/200x/\(self.getUPC).jpg"){
            if let data = NSData(contentsOfURL: url){
                myProduct.img = UIImage(data: data)!
            }
        }
        
        DBClient.myProducts.append(myProduct)
        DBClient.products.append(myProduct)
        
        
    }
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "backToML"{
            return verifyField(desricption.text!, l:prodName.text!)
            

        }
        return true
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "backToML"{
            let d = segue.destinationViewController as! MazizLIVC
            d.tableView.reloadData()
            }
    }
}
