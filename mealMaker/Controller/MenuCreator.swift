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
    //day titles: mon, tues
    @IBOutlet var otherLabels: [UILabel]!
    //day content - this is where I print dishes
    @IBOutlet var dishesCollection: [UILabel]!
    //dictionary that stores dishes by day
    var dayDict: [Int:[String]] = [1:[], 2:[], 3:[], 4:[], 5:[]]
    @IBOutlet var addDishButton: [UIButton]!
    @IBOutlet var removeDishButton: [UIButton]!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var typeValue = Int()
    var pickerView = UIPickerView()
    var currentDay = 1
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
    //updates user interface to match backend storage
    func reloadDishes(){
        for day in dishesCollection{
            day.text = ""
            for i in dayDict[Int(day.accessibilityIdentifier!)!]!{
                day.text = day.text! + ", " + i
            }
        }
    }
    
    
    override func viewDidLoad() {
        
        for label in otherLabels{
            label.layer.borderWidth = 1
        }
        
        reloadDishes()
        
        if menuName != ""{
            self.navigationItem.title = menuName
        }
        //the following makes the menu page un-editable if boolean temp.selectMenuMode is equal to true
//        if temp.selectMenuMode == true{
//            for button in addDishButton{
//                button.isHidden = true
//            }
//            saveButton = nil
//        }else{
//            for button in addDishButton{
//                button.isHidden = false
//            }
//        }
    }
    //updates firebase with current menu
    func updateMenu(name:String){
        self.db.collection(K.FStore.familyCollection).document(K.FStore.familyDocument).collection(temp.currentFamily).document(K.FStore.menuDocument).collection(K.FStore.menuCollection).document(name).setData([
            "name": name,
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
                Alert.createAlert(title: "This menu has been updated", message: "", viewController: self)

            }
           

        }
          
    }
    
    
    
    func saveAttempt(){
            if temp.menus.contains(self.menuName){
                let alert2 = UIAlertController(title: "A menu with this name already exists, would you like to update it?", message: self.menuName, preferredStyle: UIAlertController.Style.alert)
                alert2.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
                    self.updateMenu(name: self.menuName)
                    
                    alert2.dismiss(animated: true, completion: nil)
                    
                }))
                alert2.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(alert2, animated: true, completion: nil)
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
                    temp.menus.append(self.menuName)
                    print(temp.menus)

                    Alert.createAlert(title: "This menu has been added", message: "", viewController: self)

                }
               

            }
        }
        
        
    
    }
    
    
    @IBAction func savePressed(_ sender: Any) {
        
        print(dayDict)
        var textF = UITextField()
        if menuName == ""{
            
            let alert = UIAlertController(title: "What would you like to name this menu?", message: "", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
                if let text = textF.text{
                    self.menuName = text
                    self.navigationItem.title = text
                    
                    self.saveAttempt()
                    
                }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addTextField { (alertTextField) in
                textF = alertTextField
            }
            self.present(alert, animated: true, completion: nil)
        }else{
            saveAttempt()
        }
        

    }
    
    @IBAction func addDishPressed(_ sender: UIButton) {
        temp.currentMode = K.Modes.addDishToMenuMode
        temp.addDishToDay = sender.accessibilityIdentifier!
        performSegue(withIdentifier: K.Segues.MenuCreatorToDishCategories, sender: self)
    }
    
    @IBAction func removeDishPressed(_ sender: UIButton) {
        currentDay = Int(sender.accessibilityIdentifier!)!
        if let num = dayDict[currentDay]?.count{
            if num != 0{
                let alert = UIAlertController(title: "Remove dish", message: "\n\n\n\n\n\n", preferredStyle: .alert)
        //                    alert.isModalInPopover = true
                        
                        let pickerFrame = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 140))
                        
                        alert.view.addSubview(pickerFrame)
                        pickerFrame.dataSource = self
                        pickerFrame.delegate = self
                        
                        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                            
                            self.dayDict[self.currentDay]!.remove(at: self.typeValue)
                            self.reloadDishes()
                        
                        
                        }))
                        self.present(alert,animated: true, completion: nil )
            }
        }
        
        
    }
    
}

extension MenuCreator:UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dayDict[currentDay]!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dayDict[currentDay]![row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
        typeValue = row
        
        
    }
}
