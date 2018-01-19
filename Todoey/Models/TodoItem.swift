//
//  TodoItem.swift
//  Todoey
//
//  Created by Ruslan on 1/16/18.
//  Copyright © 2018 Ruslan M. All rights reserved.
//

import Foundation
import RealmSwift

class TodoItem: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "todoItems")
}
