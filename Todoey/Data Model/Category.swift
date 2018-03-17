//
//  Category.swift
//  Todoey
//
//  Created by Bryan on 3/16/18.
//  Copyright © 2018 BK. All rights reserved.
//

import Foundation
import RealmSwift  //167

class Category2: Object {   //168
    @objc dynamic var name : String = ""
    let items = List<Item2>()   //169  syntax for array of Item objects. initialized as an empty list. this step is to create relationship with the other class. class List is something from the realm framework. it's pretty much a container/array. so the relationship is that inside category, there is a property called items which is a list of item objects. 170 is on item2
}
