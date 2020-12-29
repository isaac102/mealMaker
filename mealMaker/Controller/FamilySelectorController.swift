//
//  FamilySelectorController.swift
//  mealMaker
//
//  Created by Isaac Mendelsohn on 12/20/20.
//

import Foundation
import UIKit
import Firebase
class FamilySelectorController: UIViewController{
    let db = Firestore.firestore()
    var families = temp.allFamilies
    var selectedFamily = temp.currentFamily
    
    
    @IBOutlet weak var familyPicker: UIPickerView!
    override func viewDidLoad() {
        familyPicker.dataSource = self
        familyPicker.delegate = self
        temp.loadedFirebase = false
        
        if let user = Auth.auth().currentUser?.email{
            temp.currentUser = user
        }
        
    }
    
    
    @IBAction func addFamilyPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: K.Segues.FamilySelectorToJoinFamily, sender: self)
        
    }
    
    @IBAction func goToFamilyPressed(_ sender: Any) {
        if(selectedFamily == ""){
            selectedFamily = families[0]
        }
        temp.currentFamily = selectedFamily
        performSegue(withIdentifier: K.Segues.FamiliesToHome, sender: self)
    }
    
    
    
}

extension FamilySelectorController: UIPickerViewDataSource, UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return families.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return families[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedFamily = families[row]
    }
    
    
    
    
}
