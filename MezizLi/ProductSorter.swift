//
//  ProductSorter.swift
//  MezizLi
//
//  Created by Nikolai Volodin on 08/03/2016.
//  Copyright © 2016 Nikolai Volodin. All rights reserved.
//

import Foundation
class ProductSorter:NSObject{
    class func sortProductByVotes(products:[Product])->[Product]{
        var productsToSort = products
        productsToSort.sortInPlace({ $0.voteUp > $1.voteUp })
        return productsToSort
    }
    class func sortProductByDate(products:[Product])->[Product]{
        var productsToSort = products
        productsToSort.sortInPlace({ $0.date > $1.date })
        return productsToSort
    }
}