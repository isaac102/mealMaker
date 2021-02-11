//
//  GeneralTableViewController.swift
//  mealMaker
//
//  Created by Isaac Mendelsohn on 12/15/20.
//

import Foundation
import UIKit
import Firebase
class GeneralTableViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return notIncludedCategories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return notIncludedCategories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
            typeValue = notIncludedCategories[row]
        
        
    }
    
    let db = Firestore.firestore()
    var typeValue = String()
    var pickerView = UIPickerView()
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var list:[String] = []
    var notIncludedCategories:[String] = temp.allCategories
    
    @IBOutlet weak var addItemOutlet: UIButton!
    
    var dataStorage = ""
    var alertMessage = ""
    override func viewDidLoad() {
        if temp.editDishMode{
            addItemOutlet.isHidden = false
        }else{
            addItemOutlet.isHidden = true
        }
        tableView.dataSource = self
        titleLabel.text = temp.tableViewController.controller
        
        switch temp.tableViewController.controller {
        
        case "Ingredients":
            alertMessage = "Add Ingredient"
            dataStorage = "Ingredients"
            list = temp.itemSpecifics.itemSpecificIngredients
            
        case "Category":
            titleLabel.text = "Categories"
            alertMessage = "Add Category"
            dataStorage = "Categories"
            list = temp.itemSpecifics.itemSpecificCategories
            
            
        case "Allergy Info":
            alertMessage = "Add Allergy"
            dataStorage = "AllergyInfo"
            list = temp.itemSpecifics.itemSpecificAllergyInfo
            
        default:
            return
        }
        
        
    }
    
    
    @IBAction func addCell(_ sender: UIButton) {
        
        if(dataStorage == "Categories"){
            let alert = UIAlertController(title: "Add Category", message: "\n\n\n\n\n\n", preferredStyle: .alert)
//                    alert.isModalInPopover = true
                    
                    let pickerFrame = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 140))
                    
                    alert.view.addSubview(pickerFrame)
                    pickerFrame.dataSource = self
                    pickerFrame.delegate = self
                    
                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                        
                        
                        if !self.list.contains(self.typeValue){
                            if(self.typeValue == ""){
                                self.typeValue = self.notIncludedCategories[0]
                            }
                            self.list.append(self.typeValue)
                            self.tableView.reloadData()
                        }else{
                            Alert.createAlert(title: "This category has already been added", message: "", viewController: self)
                        }
                    
                    }))
                    self.present(alert,animated: true, completion: nil )
        }else{
            var textF = UITextField()
            let alert = UIAlertController(title: alertMessage, message: "", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
                if let text = textF.text{
                    self.list.append(text)
                }
                self.tableView.reloadData()
                
                alert.dismiss(animated: true, completion: nil)
                
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addTextField { (alertTextField) in
                textF = alertTextField
            }
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        switch dataStorage {
        case "Ingredients":
            temp.itemSpecifics.itemSpecificIngredients = list
        case "Categories":
            temp.itemSpecifics.itemSpecificCategories = list
        case "AllergyInfo":
            temp.itemSpecifics.itemSpecificAllergyInfo = list
        default:
            return
        }
    }
}

extension GeneralTableViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GeneralCell", for: indexPath)
        cell.textLabel?.text = list[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
            if editingStyle == .delete{
                list.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            
            }
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        if(list[indexPath.row] == "All"){
            return false
        }
        if temp.editDishMode{
            return true
        }else{
            return false
        }
        
    }
    
    
}
