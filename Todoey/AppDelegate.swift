//
//  AppDelegate.swift
//  Todoey
//
//  Created by Ruslan on 1/10/18.
//  Copyright © 2018 Ruslan M. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        do {
            _ = try Realm()
        } catch {
            print("Error while installing new realm \(error)")
        }
        
        return true
    }

}

