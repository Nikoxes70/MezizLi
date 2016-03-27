//
//  UpDateProductVC.swift
//  MezizLi
//
//  Created by itzik nehemya on 10/03/2016.
//  Copyright © 2016 Nikolai Volodin. All rights reserved.
//

import UIKit
import AVFoundation
class UpDateProductVC: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate  {

    let DBC = DBClient.getDBClient()
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var prodImg: UIImageView!
    @IBOutlet weak var barcode: UILabel!
    @IBOutlet weak var prodName: UITextField!
    @IBOutlet weak var productDescriptionText: UITextField!
    
    private var id:Int=0;
    private var pic:UIImage = UIImage(named: "group")!
    private var UCategory:String="מזון";
    private var Ubarcode:String="";
    private var UprodName:String="";
    private var UDescription:String="";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate=self;
        
        prodImg.image=pic;
        barcode.text=Ubarcode;
        prodName.text=UprodName;
        productDescriptionText.text=UDescription;
        print(id)
    }
    
    func setUpDateProduct(Pname:String,Pdescription:String,Pimg:UIImage,id:Int,Pbarcode:String)
    {
        self.UprodName=Pname;
        self.UDescription=Pdescription;
        self.pic=Pimg;
        self.Ubarcode=Pbarcode;
        self.id=id;
    }
    
    //
    @IBAction func UpDateProduct(sender: UIButton) {
        
        Client().updateingProduct(id, name: prodName.text!, description: productDescriptionText.text!, category: UCategory);
        updateProduct();
    }
    
    var categories=["מזון","פארם","תינוקות","טיפוח","תקשורת","ביגוד","אחר"];
    
    
    //how many components in picer
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
        UCategory=categories[row];
    }
    
    
    //close the keyBoard
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true);
    }
    
    //up date the product
  
    
    //up date the DBClint Product
    func updateProduct(){
        for(var i=0; i < DBC.products.count; i++){
            if DBC.products[i].id == id{
                DBC.products[i].category=UCategory;
                DBC.products[i].name=prodName.text!;
                //DBC.products[i].description=productDescriptionText.text!;
                
            }
        }
        for(var i=0; i < DBC.myProducts.count; i++){
            if DBC.myProducts[i].id == id{
                DBC.products[i].category=UCategory;
                DBC.products[i].name=prodName.text!;
               // DBC.products[i].description=productDescriptionText.text!;
                
            }
        }
    }
    



}
