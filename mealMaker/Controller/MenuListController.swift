//
//  MenuListController.swift
//  mealMaker
//
//  Created by Isaac Mendelsohn on 1/12/21.
//


import UIKit
import Firebase
class MenuListController: UIViewController, UITableViewDelegate, UINavigationControllerDelegate{
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var tableView: UITableView!
    let db = Firestore.firestore()
    var menus = temp.menus
    var menuName = ""
    var dayDict: [Int:[String]] = [1:[], 2:[], 3:[], 4:[], 5:[]]
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        menus = temp.menus
    }
    
    func loadMenu(name:String){
        menuName = name
        
        let menu = self.db.collection(K.FStore.familyCollection).document(K.FStore.familyDocument).collection(temp.currentFamily).document(K.FStore.menuDocument).collection(K.FStore.menuCollection).document(name)
        menu.getDocument { (document, error) in
            if let document = document, document.exists{
                
                if let monday = document.data()?["1"] as? [String]{
                    self.dayDict[1] = monday
                }
                if let tuesday = document.data()?["2"] as? [String]{
                    self.dayDict[2] = tuesday
                }
                if let wednesday = document.data()?["3"] as? [String]{
                    self.dayDict[3] = wednesday
                }
                if let thursday = document.data()?["4"] as? [String]{
                    self.dayDict[4] = thursday
                }
                if let friday = document.data()?["5"] as? [String]{
                    self.dayDict[5] = friday
                }
                
                self.performSegue(withIdentifier: K.Segues.MenuListToMenu, sender: self)
            }else{
                print("document does not exist")
            }
            
            
            
            
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.MenuListToMenu{
            let destinationVC = segue.destination as! MenuCreator
            destinationVC.dayDict = self.dayDict
            destinationVC.menuName = menuName
        }

    }
    
    
}
extension MenuListController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
        cell.textLabel?.text = menus[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            loadMenu(name: menus[indexPath.row])
            
        
    }
    

    
    
}
