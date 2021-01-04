//
//  menuCreator.swift
//  mealMaker
//
//  Created by Isaac Mendelsohn on 11/23/20.
//

import Foundation
import UIKit

class MenuCreator: UIViewController{
    
    @IBOutlet var otherLabels: [UILabel]!
    @IBOutlet var dishesCollection: [UILabel]!
    
    override func viewWillAppear(_ animated: Bool) {
        if temp.currentMode == K.Modes.addDishToMenuMode{
            temp.currentMode = K.Modes.regularMode
            switch temp.addDishToDay {
            case "1":
                for label in dishesCollection{
                    if label.accessibilityIdentifier == "1"{
                        label.text = label.text! + temp.addedDish + ", "
                    }
                }
            case "2":
                for label in dishesCollection{
                    if label.accessibilityIdentifier == "2"{
                        label.text = label.text! + temp.addedDish + ", "
                    }
                }
            case "3":
                for label in dishesCollection{
                    if label.accessibilityIdentifier == "3"{
                        label.text = label.text! + temp.addedDish + ", "
                    }
                }
            case "4":
                for label in dishesCollection{
                    if label.accessibilityIdentifier == "4"{
                        label.text = label.text! + temp.addedDish + ", "
                    }
                }
            case "5":
                for label in dishesCollection{
                    if label.accessibilityIdentifier == "5"{
                        label.text = label.text! + temp.addedDish + ", "
                    }
                }
            default:
                print("error with day of week")
            }
        }
    }
    override func viewDidLoad() {
        
        
        
        for label in otherLabels{
            label.layer.borderWidth = 1
        }
    }
    
    @IBAction func addDishPressed(_ sender: UIButton) {
        temp.currentMode = K.Modes.addDishToMenuMode
        temp.addDishToDay = sender.accessibilityIdentifier!
        performSegue(withIdentifier: K.Segues.MenuCreatorToDishCategories, sender: self)
    }
}
