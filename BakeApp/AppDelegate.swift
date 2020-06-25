//
//  AppDelegate.swift
//  BakeApp
//
//  Created by Alex Moran on 5/17/20.
//  Copyright © 2020 Alex Moran. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
            FirebaseApp.configure()
            let db = Firestore.firestore()
            let webRecipe = db.collection("recipes").document("2")
            var ingxins = [[Int]]()
            webRecipe.getDocument { (document, error) in
                if let data = document?.data() {
                    var tempRecipe = data
                    if let ingxinsString = data["secretingxins"] as? String {
                        let array = ingxinsString.components(separatedBy: "|")
                        var doubleArray = Array(repeating: [], count: array.count)
                        for index in 0..<array.count {
                            let value = array[index]
                            if value != "nil" {
                                let smallArray = value.components(separatedBy: ",")
                                var intArray = Array(repeating: 0, count: smallArray.count)
                                for counter in 0..<smallArray.count {
                                    let val = smallArray[counter]
                                    let intVal = Int(val)
                                    intArray[counter] = intVal ?? 0
                                }
                                doubleArray[index] = intArray
                            }
                        }
                        ingxins = doubleArray as? [[Int]] ?? [[0]]
                        tempRecipe["ingxins"] = ingxins
                        print("\(tempRecipe)")
                    }
                }

                print("Global var ingxins: \(ingxins)")

                let result = Result {
                    try document?.data(as: Recipe.self)
                }

                switch result {
                case .success(let recipe):
                    if recipe != nil {
                        var realRecipe = recipe!
                        realRecipe.ingxins = ingxins
                        // A `Recipe` value was successfully initialized from the DocumentSnapshot.
                        print("Recipe: \(realRecipe)")
                        recipeData.append(realRecipe)
                    } else {
                        // A nil value was successfully initialized from the DocumentSnapshot,
                        // or the DocumentSnapshot was nil.
                        print("Document does not exist")
                    }
                case .failure(let error):
                    // A `Recipe` value could not be initialized from the DocumentSnapshot.
                    print("Error decoding recipe: \(error)")
                }
            }

        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "BakeApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
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

