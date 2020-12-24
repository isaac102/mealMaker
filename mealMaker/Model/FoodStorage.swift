//
//  FoodStorage.swift
//  mealMaker
//
//  Created by Isaac Mendelsohn on 11/30/20.
//

import Foundation
import Firebase
struct FoodStorage {
    
    static var dishes: [Dish] = []
    
    
    static func getDishNames() -> [String]{
        var names:[String] = []
        for dish in dishes{
            names.append(dish.name)
        }
        return names
    }
    
    static func containsDish(name: String) -> Bool{
        for storedName in FoodStorage.getDishNames(){
            if name == storedName{
                return true
            }
        }
        return false
    }
    
    static func createSampleDish(familyName: String){
        let db = Firestore.firestore()
        var dish = Dish(name: "Sample Dish", category: ["All"], allergyInfo: ["Dairy"], ingredients: ["Ingredient1", "Ingredient2"], directions: "directions to make dish", notes: "notes about dish")
        db.collection(K.FStore.familyCollection).document(K.FStore.familyDocument).collection(familyName).document(K.FStore.dishCollection).collection(K.FStore.dishCollection).document(dish.name).setData([
            "name": dish.name,
            "category": dish.category,
            "allergy": dish.allergyInfo,
            "ingredients": dish.ingredients,
            "notes": dish.notes
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                
            }
        }
    }
}
