//
//  menuCreator.swift
//  mealMaker
//
//  Created by Isaac Mendelsohn on 11/23/20.
//

import Foundation
import UIKit
import Firebase
class MenuCreator: UIViewController{
    let db = Firestore.firestore()
    @IBOutlet var otherLabels: [UILabel]!
    @IBOutlet var dishesCollection: [UILabel]!
    var dayDict: [Int:[String]] = [1:[], 2:[], 3:[], 4:[], 5:[]]
    var menuName = ""
    override func viewWillAppear(_ animated: Bool) {
        if temp.currentMode == K.Modes.addDishToMenuMode{
            temp.currentMode = K.Modes.regularMode
            switch temp.addDishToDay {
            case "1":
                for label in dishesCollection{
                    if label.accessibilityIdentifier == "1"{
                        label.text = label.text! + temp.addedDish + ", "
                        dayDict[1]?.append(temp.addedDish)
                    }
                }
            case "2":
                for label in dishesCollection{
                    if label.accessibilityIdentifier == "2"{
                        label.text = label.text! + temp.addedDish + ", "
                        dayDict[2]?.append(temp.addedDish)
                    }
                }
            case "3":
                for label in dishesCollection{
                    if label.accessibilityIdentifier == "3"{
                        label.text = label.text! + temp.addedDish + ", "
                        dayDict[3]?.append(temp.addedDish)
                    }
                }
            case "4":
                for label in dishesCollection{
                    if label.accessibilityIdentifier == "4"{
                        label.text = label.text! + temp.addedDish + ", "
                        dayDict[4]?.append(temp.addedDish)
                    }
                }
            case "5":
                for label in dishesCollection{
                    if label.accessibilityIdentifier == "5"{
                        label.text = label.text! + temp.addedDish + ", "
                        dayDict[5]?.append(temp.addedDish)
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
    @IBAction func savePressed(_ sender: Any) {
        print(dayDict)
        
        
        var textF = UITextField()
        let alert = UIAlertController(title: "What would you like to name this menu?", message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            if let text = textF.text{
                self.menuName = text
            }
            if temp.menus.contains(self.menuName){
                Alert.createAlert(title: "A menu with this name already exists", message: self.menuName, viewController: self)
                alert.dismiss(animated: true, completion: nil)
            }else{
            
            self.db.collection(K.FStore.familyCollection).document(K.FStore.familyDocument).collection(temp.currentFamily).document(K.FStore.menuDocument).collection(K.FStore.menuCollection).document(self.menuName).setData([
                "name": self.menuName,
                "1":self.dayDict[1],
                "2":self.dayDict[2],
                "3":self.dayDict[3],
                "4":self.dayDict[4],
                "5":self.dayDict[5]
            ])
                { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")

                }
            }
            alert.dismiss(animated: true, completion: nil)
        }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addTextField { (alertTextField) in
            textF = alertTextField
        }
        self.present(alert, animated: true, completion: nil)
        
        
        
    }
    
    @IBAction func addDishPressed(_ sender: UIButton) {
        temp.currentMode = K.Modes.addDishToMenuMode
        temp.addDishToDay = sender.accessibilityIdentifier!
        performSegue(withIdentifier: K.Segues.MenuCreatorToDishCategories, sender: self)
    }
}
