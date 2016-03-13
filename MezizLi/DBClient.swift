//
//  DBClient.swift
//  Maziz li
//
//  Created by itzik nehemya on 02/03/2016.
//  Copyright © 2016 itzik nehemya. All rights reserved.
//

import Foundation
import UIKit

public class DBClient{
    
    var products:[Product] = []
    var myProducts:[Product] = []

    
    private static var DBC : DBClient!
    
    private init(){}

    public static func getDBClient()->DBClient{
        DBClient.DBC == nil ? DBClient.DBC = DBClient() : ();
        return DBClient.DBC
        
    }
}