//
//  Temp.swift
//  mealMaker
//
//  Created by Isaac Mendelsohn on 11/26/20.
//

import Foundation

public class temp{
    
    
    static var dishes:[[String: Any]] = []
    static var currentUser = ""
    static var loadedFirebase = false
    static var currentFamily:String = ""
    static var allFamilies:[String] = ["No family yet, please join or create one"]
    
    static var allCategories: [String] = ["All", "Meat", "Dairy", "Poultry", "Vegetables", "Fruits", "Carbs"]
    
    
    
    struct tableViewController{
        static var controller = "General Use"
    }
    
    struct itemSpecifics{
        static var itemSpecificName: String = ""
        static var itemSpecificCategories: [String] = ["All"]
        static var itemSpecificAllergyInfo: [String] = []
        static var itemSpecificDirections: String = ""
        static var itemSpecificNotes:String = ""
        static var itemSpecificIngredients: [String] = []
    }
    
}
