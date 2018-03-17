//
//  AppDelegate.swift
//  Todoey
//
//  Created by Bryan on 3/7/18.
//  Copyright © 2018 BK. All rights reserved.
//

import UIKit
import CoreData //68
import RealmSwift   //153

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)  //32 just for her to show us. open up the mac finder. mac hd, users, your name, library, developer, coresimulator, devices, search for whatever shit appears which is the UUID/device ID, data, containers, data, application, search for app UID which is the unique todoey app id, documents, library, preferences, then you get to the plist. 33 back on todolistvc
        
        print(Realm.Configuration.defaultConfiguration.fileURL)  //162 location of realm file . hit command shift G. delete beg so that it is /Users.    163 on notes
        
    /*    let data = Data()  //159
        data.name = "Bryan"
        data.age = 27
        */
        
        do {   //154. 155 on notes
        let realm = try Realm()
         //   try realm.write {   //160 realm.write means to commit this current state to realm database
          //      realm.add(data)  //161 adding the data object which is a realm model object due to inheritance to realm database
          //  }
        } catch {
            print("Error initializing new realm, \(error)")
        }

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    //81 when you have a lazy variable, then it only gets loaded up with a value when its needed i.e when you use this thing called persistent container. nspersistentcontainer is a sqlite database. its where we gna store our data. 82 on todolistvc
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")   //69 change name to the same name as data model . 70 on notes
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    //context is an area where you can change and update your data so you can undo and redo until youre happy with your data and then you can save your data/context. context is similar to staging area. only when we're ready do we commit.
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }


}

