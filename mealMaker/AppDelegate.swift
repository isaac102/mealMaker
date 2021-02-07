//
//  AppDelegate.swift
//  mealMaker
//
//  Created by Isaac Mendelsohn on 11/19/20.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        FirebaseApp.configure()
        
        
        let db = Firestore.firestore()
//        LoadFirebase.loadDishes()
        let mainScreenVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "NavigationController")
        if let email =  Auth.auth().currentUser?.email{
                
                let userDoc = db.collection(K.FStore.userCollection).document(email)
            
                userDoc.getDocument { (document, error) in
                        if let document = document, document.exists{
                            
                            if let fam = document.data()?["families"] as? [String]{
                                
                                temp.allFamilies = fam
                                print("families set")
                                
                                self.window?.rootViewController = mainScreenVC
                            }
                
                            
                        }else{
                     
                            print("document does not exist")
                        }
                        
                    }
            
            temp.currentUser = email
            print("set user email")
            return true
        } else {
            
            self.window?.rootViewController = mainScreenVC
            print("no user")
            return true
        }
        
    }
    
    

   

}

