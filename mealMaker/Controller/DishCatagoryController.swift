//
//  DishCategoryController.swift
//  mealMaker
//
//  Created by Isaac Mendelsohn on 12/3/20.
//

import Foundation
import UIKit
import Firebase

import IQKeyboardManagerSwift
class DishCategoryController:UIViewController, UITableViewDelegate{
    let db = Firestore.firestore()

    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var correctDishes: [[String: Any]] = []

    var categories: [String] {
        return temp.allCategories
    }
    
    @IBAction func stoppedSearch(_ sender: UITextField) {
        for i in temp.dishes{
            print("categories are \(type(of: i["category"]))")
            var middle: [[String]] = []
            if type(of: i["category"]) != type(of: [["blah"], ["ble"]]){
                middle = [i["category"]] as! [[String]]
            }else{
                middle = i["category"] as! [[String]]
            }
            let cats:[[String]] = middle
            let names:String = i["name"] as! String
            print("\(names) has categories \(cats)")
            for cat in cats{
                for cata in cat{
                    if cata.lowercased().contains(sender.text!.lowercased()){
                        self.correctDishes.append(i)
                    }
                }
            }
            
            
            if names.lowercased().contains(sender.text!.lowercased()){
                var alreadyAddedDishes:[String] = []
                for added in correctDishes{
                    if let addedDish = added["name"] as? String{
                        alreadyAddedDishes.append(addedDish)
                    }
                }
                if !alreadyAddedDishes.contains(i["name"] as! String){
                    self.correctDishes.append(i)
                }
                
            }
            
                
            
        }
        self.performSegue(withIdentifier: K.Segues.dishCategoriesToDishes, sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        temp.allCategories = temp.allCategories.sorted { $0.lowercased() < $1.lowercased() }
        correctDishes = []
        temp.inCategory = ""
    }
    override func viewDidLoad() {
        temp.inCategory = ""
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 80.0

        
    }
    
    
    func loadDishes(selectedCategory: String){
        if(temp.loadedFirebase == true){
            for i in temp.dishes{
                if let cats:[String] = i["category"] as? [String]{
                    if cats.contains(selectedCategory){
                        correctDishes.append(i)
                    }
                }
            }
            self.performSegue(withIdentifier: K.Segues.dishCategoriesToDishes, sender: self)
            
            return
        }
        
        db.collection(K.FStore.familyCollection).document(K.FStore.familyDocument).collection(temp.currentFamily).document(K.FStore.dishCollection).collection(K.FStore.dishCollection).getDocuments { (querySnapshot, error) in
            if let e = error {
                print("there was an error retrieving data from firestore: \(e)")
                
            }else{
                if let snapshotDocument = querySnapshot?.documents{
                    var holdDishes:[[String:Any]] = []
                    for doc in snapshotDocument{
                        holdDishes.append(doc.data())
                    }
                    temp.dishes = holdDishes
                }
            }
            
            for i in temp.dishes{
                if let cats:[String] = i["category"] as? [String]{
                    if cats.contains(selectedCategory){
                        self.correctDishes.append(i)
                    }
                }
            }
            self.performSegue(withIdentifier: K.Segues.dishCategoriesToDishes, sender: self)
        }
        
        
        
    }
    
    func saveToFirebase(){
        self.db.collection(K.FStore.familyCollection).document(K.FStore.familyDocument).collection(temp.currentFamily).document(K.FStore.dishCollection).setData([
            "categories" : categories
        ])
    }
    
    
    @IBAction func addCategory(_ sender: Any) {
        var textF = UITextField()
        
        let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            if let text = textF.text{
                let capitalized = text.capitalized
                temp.allCategories.append(capitalized)
            }
            self.tableView.reloadData()
            self.saveToFirebase()
            
            alert.dismiss(animated: true, completion: nil)
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addTextField { (alertTextField) in
            textF = alertTextField
        }
        self.present(alert, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.dishCategoriesToDishes{
            let destinationVC = segue.destination as! DishListController
            destinationVC.dishes = self.correctDishes
            
        }
    }
    
   
}

extension DishCategoryController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DishCategoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if(categories[indexPath.row] == "All"){
            return false
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            temp.allCategories.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveToFirebase()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        temp.inCategory = categories[indexPath.row]
        loadDishes(selectedCategory: categories[indexPath.row])
        
        
    }
    
    
    
    
    
    
}

