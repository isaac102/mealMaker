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
    var alteredPicker = false
    
    
    @IBOutlet weak var familyPicker: UIPickerView!
    override func viewDidLoad() {
        familyPicker.dataSource = self
        familyPicker.delegate = self
        temp.loadedFirebase = false
        self.title = temp.currentUser
        navigationItem.hidesBackButton = true
        if let user = Auth.auth().currentUser?.email{
            temp.currentUser = user
        }
        
    }
    
    @IBAction func logOutPressed(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            temp.currentUser = ""
            self.navigationController?.popToRootViewController(animated: true)
        }catch let signOutError as NSError{
            Alert.createAlert(title: "Error", message: "Error signing out :\(signOutError)", viewController: self)
        }
    }
    
    @IBAction func addFamilyPressed(_ sender: UIButton) {
        if !alteredPicker{
            familyPicker.selectRow(0, inComponent: 0, animated: true)

        }
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
        alteredPicker = true
        selectedFamily = families[row]
    }
    
        
    
    
    
}
