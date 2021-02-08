//
//  Temp.swift
//  mealMaker
//
//  Created by Isaac Mendelsohn on 11/26/20.
//

import Foundation

public class temp{
    
    static var mustReturnToMenuCreator = false
    static var transitionDictionary: [Int:[String]] = [1:[], 2:[], 3:[], 4:[], 5:[]]
    static var useTransitionDictionary = false
    static var dishes:[[String: Any]] = []
    static var menus:[String] = []
    static var currentUser = ""
    static var loadedFirebase = false
    static var currentFamily:String = ""
    static var allFamilies:[String] = ["No family yet, please join or create one"]
    static var currentMode = K.Modes.regularMode
    static var addedDish = ""
    static var addDishToDay = "0"
    static var allCategories: [String] = []
    static var editDishMode = true
    static var inCategory = ""
    static var selectMenuMode = false
    
    
    
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
    
    static func containsDish(name:String) -> Bool{
        for dish in dishes{
            if name == dish["name"] as! String{
                return true
            }
        }
        return false
    }
    
    
}
