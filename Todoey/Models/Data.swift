//
//  Data.swift
//  Todoey
//
//  Created by Ruslan on 1/16/18.
//  Copyright © 2018 Ruslan M. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
}
