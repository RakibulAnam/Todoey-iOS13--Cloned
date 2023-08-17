//
//  Category.swift
//  Todoey
//
//  Created by Jotno on 8/17/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object{
    
    //properties
    @objc dynamic var name : String = ""
   
    
    //forward Relationships
    let items = List<Item>()
    
}
