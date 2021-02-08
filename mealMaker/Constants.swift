//
//  Constants.swift
//  mealMaker
//
//  Created by Isaac Mendelsohn on 11/25/20.
//

import Foundation

struct K {
    struct Segues{
        static let FirstSegue = "FirstSegue"
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
        static let FamilySelectorToJoinFamily = "FamilySelectorToJoinFamily"
        static let MenuCreatorToDishCategories = "MenuCreatorToDishCategories"
        static let DishListToDishCreator = "DishListToDishCreator"
        static let MenuListToMenu = "MenuListToMenu"
        static let SetUpToMenu = "SetUpToMenu"
        static let WelcomeToMenus = "WelcomeToMenus"
        static let MenuCreatorToMenuList = "MenuCreatorToMenuList"
    }
    
    struct FStore{
        static let dishCollection = "dishes"
        static let familyCollection = "families"
        static let familyDocument = "familiesDocument"
        static let userCollection = "users"
        static let passwordDocument = "password"
        static let adminUsersDocument = "adminUsers"
        static let regularUsers = "regularUsers"
        static let menuDocument = "menus"
        static let menuCollection = "menus"
        static let menuDetails = "menuDetails"
        
    }
    
    struct Modes{
        static let addDishToMenuMode = "addDishToMenuMode"
        static let regularMode = "regularMode"
    }
}
