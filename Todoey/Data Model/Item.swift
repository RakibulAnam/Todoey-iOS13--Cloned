//
//  Item.swift
//  Todoey
//
//  Created by Jotno on 8/17/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object{
    
    
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    
    
    //Inverse Relationship [property the name of the value that links with the forward relationship ]
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
