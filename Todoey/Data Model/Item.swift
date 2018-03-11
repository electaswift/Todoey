//
//  Item.swift
//  Todoey
//
//  Created by Bryan on 3/10/18.
//  Copyright © 2018 BK. All rights reserved.
//

import Foundation

class Item: Encodable, Decodable {    //34. 35 on todolistvc.  56 is to make it conform to protocol Encodable. this makes it so that the Item type can encode itself into a plist or a json. 58 on todolistvc. 64. since swift 4, you can just conform to "Codable" 
    
    var title = ""
    var done = false
    

}
