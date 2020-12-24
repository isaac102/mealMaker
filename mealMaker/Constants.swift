//
//  Constants.swift
//  mealMaker
//
//  Created by Isaac Mendelsohn on 11/25/20.
//

import Foundation

struct K {
    struct Segues{
        static let logInToFamilies = "LogInToFamilies"
        static let logInToFamilyJoin = "logInToFamilyJoin"
        static let registerToFamilies = "registerToFamilies"
        static let registerToFamilyJoin = "registerToFamilyJoin"
        static let welcomeToMenuCreator = "WelcomeToMenuCreator"
        static let welcomeToDishCreator = "WelcomeToDishCreator"
        static let WelcomeToDishCategories = "WelcomeToDishCategories"
        static let menuCreatorToItem = "MenuCreatorToItemDetail"
        static let dishCreatorToItemDetail = "DishCreatorToItemDetail"
        static let dishCreatorToIngredients = "DishCreatorToIngredients"
        static let dishCategoriesToDishes = "DishCategoriesToDishes"
        static let DishCreatorToGeneralUse = "DishCreatorToGeneralUse"
        static let FamiliesToHome = "FamiliesToHome"
        static let familyJoinToWelcome = "familyJoinToWelcome"
        
        
    }
    
    struct FStore{
        static let dishCollection = "dishes"
        static let familyCollection = "families"
        static let familyDocument = "familiesDocument"
        static let userCollection = "users"
        static let passwordDocument = "password"
    }
}
