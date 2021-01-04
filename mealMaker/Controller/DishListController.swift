//
//  DishListController.swift
//  mealMaker
//
//  Created by Isaac Mendelsohn on 12/9/20.
//

import Foundation
import UIKit
import Firebase
class DishListController: UIViewController, UITableViewDelegate, UINavigationControllerDelegate{
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var tableView: UITableView!
    let db = Firestore.firestore()
    var dishes = temp.dishes
    

    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        dishes = temp.dishes

    }
    
    
    
    
    
    
    
    
}
extension UINavigationController {
    func getViewController<T: UIViewController>(of type: T.Type) -> UIViewController? {
        return self.viewControllers.first(where: { $0 is T })
    }

    func popToViewController<T: UIViewController>(of type: T.Type, animated: Bool) {
        guard let viewController = self.getViewController(of: type) else { return }
        self.popToViewController(viewController, animated: animated)
    }
}
extension DishListController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Called!")
        let cell = tableView.dequeueReusableCell(withIdentifier: "DishCell", for: indexPath)
        cell.textLabel?.text = dishes[indexPath.row]["name"] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if temp.currentMode == K.Modes.addDishToMenuMode{
            let alert = UIAlertController(title: "Would you like to add this dish?", message: self.dishes[indexPath.row]["name"] as! String, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
                temp.addedDish = self.dishes[indexPath.row]["name"] as! String
                self.navigationController?.popToViewController(of: MenuCreator.self, animated: true)

                alert.dismiss(animated: true, completion: nil)
                
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
       
        
            if editingStyle == .delete{
                db.collection(K.FStore.familyCollection).document(K.FStore.familyDocument).collection(temp.currentFamily).document(K.FStore.dishCollection).collection(K.FStore.dishCollection).document(dishes[indexPath.row]["name"] as! String).delete() { err in
                    if let err = err {
                        print("Error removing document: \(err)")
                    } else {
                        print("Document successfully removed!")
                        self.dishes.remove(at: indexPath.row)
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    }
                }
                
                
            
        }
        
    }
    
    
}
