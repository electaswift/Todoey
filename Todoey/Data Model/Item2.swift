//
//  Item2.swift
//  Todoey
//
//  Created by Bryan on 3/16/18.
//  Copyright © 2018 BK. All rights reserved.
//

import Foundation
import RealmSwift  //165

class Item2: Object {    //166. 167 is on Category
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    var parentCategory = LinkingObjects(fromType: Category2.self, property: "items")      //170 each item has an inverse relationship to a category. what is the parent object and what is the property called.  171 is on categoryvc
}

