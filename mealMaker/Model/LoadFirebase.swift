//
//  LoadFirebase.swift
//  mealMaker
//
//  Created by Isaac Mendelsohn on 12/10/20.
//

import Foundation
import Firebase
class LoadFirebase{
    
    public static func loadFirebase(){
        loadMenus()
        loadDishCategories()
        loadDishes()
        
        temp.loadedFirebase = true
    }
    
    
    public static func loadDishes(){
        let db = Firestore.firestore()
        db.collection(K.FStore.familyCollection).document(K.FStore.familyDocument).collection(temp.currentFamily).document(K.FStore.dishCollection).collection(K.FStore.dishCollection).getDocuments { (querySnapshot, error) in
            if let e = error {
                print("there was an error retrieving data from firestore: \(e)")
                
            }else{
                if let snapshotDocument = querySnapshot?.documents{
                    var holdDishes:[[String:Any]] = []
                    for doc in snapshotDocument{
                        holdDishes.append(doc.data())
                        
                    }
                    temp.dishes = holdDishes
                }
            }
            temp.loadedFirebase = true
        }
    }
    
    public static func loadDishCategories(){
        let db = Firestore.firestore()
        let userDoc = db.collection(K.FStore.familyCollection).document(K.FStore.familyDocument).collection(temp.currentFamily).document(K.FStore.dishCollection)
        userDoc.getDocument { (document, error) in
            if let document = document, document.exists{
                if let category = document.data()?["categories"] as? [String]{
                    if category.count != 0{
                        temp.allCategories = category
                    }else{
                        db.collection(K.FStore.familyCollection).document(K.FStore.familyDocument).collection(temp.currentFamily).document(K.FStore.dishCollection).setData([
                            "categories" : ["All", "Meat", "Dairy", "Poultry", "Vegetables", "Fruits", "Carbs"]
                        ])
                        temp.allCategories = ["All", "Meat", "Dairy", "Poultry", "Vegetables", "Fruits", "Carbs"]
                    }
                    
                    
                }else{
                    db.collection(K.FStore.familyCollection).document(K.FStore.familyDocument).collection(temp.currentFamily).document(K.FStore.dishCollection).setData([
                        "categories" : ["All", "Meat", "Dairy", "Poultry", "Vegetables", "Fruits", "Carbs"]
                    ])
                    temp.allCategories = ["All", "Meat", "Dairy", "Poultry", "Vegetables", "Fruits", "Carbs"]
                }
                
            }else{
                db.collection(K.FStore.familyCollection).document(K.FStore.familyDocument).collection(temp.currentFamily).document(K.FStore.dishCollection).setData([
                    "categories" : ["All", "Meat", "Dairy", "Poultry", "Vegetables", "Fruits", "Carbs"]
                ])
                temp.allCategories = ["All", "Meat", "Dairy", "Poultry", "Vegetables", "Fruits", "Carbs"]
                print("document does not exist")
            }
            
            
        }
    }
    
    public static func loadMenus(){
        let db = Firestore.firestore()

        db.collection(K.FStore.familyCollection).document(K.FStore.familyDocument).collection(temp.currentFamily).document(K.FStore.menuDocument).collection(K.FStore.menuCollection).getDocuments { (querySnapshot, error) in
            if let e = error {
                print("there was an error retrieving data from firestore: \(e)")
                
            }else{
                if let snapshotDocument = querySnapshot?.documents{
                    var holdMenus:[String] = []
                    for doc in snapshotDocument{
                        holdMenus.append(doc.data()["name"] as! String)
                    }
                    temp.menus = holdMenus
                }
            }
            
        }
    }
    
    
    
}
