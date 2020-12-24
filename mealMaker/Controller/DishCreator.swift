//
//  dishCreator.swift
//  mealMaker
//
//  Created by Isaac Mendelsohn on 11/23/20.
//

import Foundation
import UIKit
import Firebase
class DishCreator: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return temp.allCategories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return temp.allCategories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        typeValue = temp.allCategories[row]
    }
    
    var typeValue = String()
    let db = Firestore.firestore()
    var itemName = ""
    var pickerView = UIPickerView()
    
    @IBOutlet weak var dish: UITextField!
    var categoryList = ["All"]
     
    var food = ""
    
    var ingredients: [String] = temp.itemSpecifics.itemSpecificIngredients
    
    
    
    
    override func viewDidLoad() {
        
   
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        temp.itemSpecifics.itemSpecificIngredients = []
        temp.itemSpecifics.itemSpecificCategories = ["All"]
        temp.itemSpecifics.itemSpecificAllergyInfo = []
        temp.itemSpecifics.itemSpecificName = ""
        temp.itemSpecifics.itemSpecificNotes = ""
        temp.itemSpecifics.itemSpecificDirections = ""
    }
    
    @IBAction func toIngredients(_ sender: Any) {
   
        self.performSegue(withIdentifier: K.Segues.dishCreatorToIngredients, sender: self)

    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        itemName = sender.currentTitle!
        temp.tableViewController.controller = sender.currentTitle!
        switch itemName {
        case "Ingredients":
            self.performSegue(withIdentifier: K.Segues.DishCreatorToGeneralUse, sender: self)
        case "Directions":
            self.performSegue(withIdentifier: K.Segues.dishCreatorToItemDetail, sender: self)
        case "Notes":
            self.performSegue(withIdentifier: K.Segues.dishCreatorToItemDetail, sender: self)
        case "Category":
            self.performSegue(withIdentifier: K.Segues.DishCreatorToGeneralUse, sender: self)
        case "Allergy Info":
            self.performSegue(withIdentifier: K.Segues.DishCreatorToGeneralUse, sender: self)
        default:
            return
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.dishCreatorToItemDetail{
            let destinationVC = segue.destination as! ItemDetail
            destinationVC.itemName = self.itemName
        }
    }
    
    @IBAction func addCategoryPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Add Category", message: "\n\n\n\n\n\n", preferredStyle: .alert)
                alert.isModalInPopover = true
                
                let pickerFrame = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 140))
                
                alert.view.addSubview(pickerFrame)
                pickerFrame.dataSource = self
                pickerFrame.delegate = self
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                    
                    print("You selected " + self.typeValue )
                    if !self.categoryList.contains(self.typeValue){
                        self.categoryList.append(self.typeValue)
                        
                    }else{
                        Alert.createAlert(title: "This category has already been added", message: "", viewController: self)
                    }
                
                }))
                self.present(alert,animated: true, completion: nil )
       
    }
    

    
    @IBAction func savePressed(_ sender: Any) {
        
        if dish.text == ""{
            Alert.createAlert(title: "Every dish needs a name", message: "", viewController: self)
            return
        }
        if let name = dish.text{
            if(!FoodStorage.containsDish(name: name)){
                
                FoodStorage.dishes.append(Dish(name: name, category: temp.itemSpecifics.itemSpecificCategories, allergyInfo: temp.itemSpecifics.itemSpecificAllergyInfo, ingredients: temp.itemSpecifics.itemSpecificIngredients, directions: temp.itemSpecifics.itemSpecificDirections, notes: temp.itemSpecifics.itemSpecificNotes))
                Alert.createAlert(title: "Dish Created!", message: "\(self.dish.text!)", viewController: self)
            }else{
                Alert.createAlert(title: "A dish with this name exists", message: "", viewController: self)
            }
        }else{
            print("error-------------error---------------error---------------error")
        }
        //print(FoodStorage.dishes)
//        for dish in FoodStorage.dishes{
//            db.collection(K.FStore.dishCollection).document(dish.name).setData([
//                "name": dish.name,
//                "category": categoryList,
//                "allergy": dish.allergyInfo,
//                "ingredients": dish.ingredients,
//                "notes": dish.notes
//            ]) { err in
//                if let err = err {
//                    print("Error writing document: \(err)")
//                } else {
//                    print("Document successfully written!")
//
//                }
//            }
//
//        }
        
        //load firebase into family storage
        for dish in FoodStorage.dishes{
            db.collection(K.FStore.familyCollection).document(K.FStore.familyDocument).collection(temp.currentFamily).document(K.FStore.dishCollection).collection(K.FStore.dishCollection).document(dish.name).setData([
                "name": dish.name,
                "category": categoryList,
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
        
        LoadFirebase.loadDishes()
        
    }
    
    
    
}
