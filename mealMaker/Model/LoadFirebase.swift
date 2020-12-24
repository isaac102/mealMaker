//
//  LoadFirebase.swift
//  mealMaker
//
//  Created by Isaac Mendelsohn on 12/10/20.
//

import Foundation
import Firebase
class LoadFirebase{
    
    
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
    
    
    
}
