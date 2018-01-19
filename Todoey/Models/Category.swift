//
//  Category.swift
//  Todoey
//
//  Created by Ruslan on 1/16/18.
//  Copyright © 2018 Ruslan M. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var title: String = ""
    let todoItems = List<TodoItem>()
}
