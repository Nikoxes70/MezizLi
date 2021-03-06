//
//  Validator.swift
//  MezizLi
//
//  Created by Nikolai Volodin on 08/03/2016.
//  Copyright © 2016 Nikolai Volodin. All rights reserved.
//
import UIKit

class Validator: NSObject {

    func getValidPhoneNumber(stringToValidate: String) -> String? {
        let digitsOnlyNumber = getOnlyDigitsNumber(stringToValidate)
        if (validatePhoneNumber(digitsOnlyNumber)) {
            return digitsOnlyNumber
        }
        return nil
        
    }
    
    private func validatePhoneNumber(digitsOnlyNumber: String) -> Bool{
        //let twoDigitAreaCodes = ["02", "03", "04", "08", "09"]
        let threeDigitAreaCodes = ["050", "052", "053", "054", "055", "056", "058", "059"]
        // The list above is based on "http://he.wikipedia.org/wiki/קידומת_טלפון_בישראל"
        
        // Check if phone lenght is 10 digits
        if digitsOnlyNumber.characters.count == 10 {
            // Check if the three digit area code is legal
            if checkAreaCode(digitsOnlyNumber,areaCodes: threeDigitAreaCodes) {
                return true
            }
        }
        
        return false
    }
    
    private func getOnlyDigitsNumber(numberString: String) -> String {
        // Remove all characters that are not numbers
        let legalCharsInPhone:Array<Character> = ["0", "1", "2", "3" ,"4", "5", "6", "7", "8", "9"]
        var tempPhoneString = "" // Reset variable to empty string
        for digitChar in numberString.characters {
            if legalCharsInPhone.contains(digitChar) {
                tempPhoneString += String(digitChar)
            }
        }
        
        return tempPhoneString
    }
    //Checks the area code if exist
    private func checkAreaCode(phoneNumber: String, areaCodes: [String]) -> Bool {
        for areaCode in areaCodes {
            if phoneNumber.hasPrefix(areaCode) {
                return true
            }
        }
        
        return false
    }
}
