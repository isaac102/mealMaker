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
    var categories: [String] {
        return temp.allCategories
    }
    
    override func viewWillAppear(_ animated: Bool) {
        temp.allCategories = temp.allCategories.sorted { $0.lowercased() < $1.lowercased() }
    }
    override func viewDidLoad() {
        print("got this far")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 80.0

        
    }
    
    
    func loadDishes(){
        if(temp.loadedFirebase == true){
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
            
            
            self.performSegue(withIdentifier: K.Segues.dishCategoriesToDishes, sender: self)
        }
        
        
        
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

            
            alert.dismiss(animated: true, completion: nil)
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addTextField { (alertTextField) in
            textF = alertTextField
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        loadDishes()
        
        
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
        }
    }
    
    
    
    
    
    
}

