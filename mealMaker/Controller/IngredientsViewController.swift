//
//  IngredientsViewController.swift
//  mealMaker
//
//  Created by Isaac Mendelsohn on 11/24/20.
//

import Foundation
import UIKit
import Firebase
class IngredientsViewController:UIViewController{
    
    let db = Firestore.firestore()
    
    
    @IBOutlet weak var tableView: UITableView!
    var ingredients: [String] = temp.itemSpecifics.itemSpecificIngredients
    
    override func viewDidLoad() {
        
        tableView.dataSource = self
        
        
    }
    
    
    @IBAction func addSelected(_ sender: UIButton) {
        var textF = UITextField()
        
        let alert = UIAlertController(title: "Add Ingredient", message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            if let text = textF.text{
                self.ingredients.append(text)
            }
            self.tableView.reloadData()
            
            alert.dismiss(animated: true, completion: nil)
            
        }))
        alert.addTextField { (alertTextField) in
            textF = alertTextField
        }
        self.present(alert, animated: true, completion: nil)
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {

        temp.itemSpecifics.itemSpecificIngredients = ingredients

    }
    
    
   
}

extension IngredientsViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
        cell.textLabel?.text = ingredients[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            ingredients.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
}
