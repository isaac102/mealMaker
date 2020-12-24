//
//  Dish.swift
//  mealMaker
//
//  Created by Isaac Mendelsohn on 11/30/20.
//

import Foundation

struct Dish{
    var name: String
    var category: [String]
    var allergyInfo: [String]
    var ingredients: [String]
    var directions: String
    var notes: String
    
    init(name: String, category: [String], allergyInfo: [String], ingredients: [String], directions: String, notes: String) {
        self.name = name
        self.category = category
        self.allergyInfo = allergyInfo
        self.ingredients = ingredients
        self.directions = directions
        self.notes = notes
    }
}
