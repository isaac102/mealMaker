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
    @IBOutlet weak var addMenuButton: UIBarButtonItem!
    var selectingWeeklyMenu = false
    
    override func viewDidLoad() {
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        if selectingWeeklyMenu || temp.mustReturnToMenuCreator{
            Alert.createAlert(title: "Please select a menu as the weekly menu", message: "", viewController: self)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        selectingWeeklyMenu = false
        temp.mustReturnToMenuCreator = false
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
    
    func setAsWeeklyMenu(selectedMenu:String){
        let menu = self.db.collection(K.FStore.familyCollection).document(K.FStore.familyDocument).collection(temp.currentFamily).document(K.FStore.menuDocument).collection(K.FStore.menuCollection).document(selectedMenu)
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
                temp.transitionDictionary = self.dayDict
                
                temp.useTransitionDictionary = true
                self.navigationController?.popViewController(animated: true)
                self.db.collection(K.FStore.familyCollection).document(K.FStore.familyDocument).collection(temp.currentFamily).document(K.FStore.menuDocument).collection(K.FStore.menuCollection).document("weeklyMenu").setData([
                    "name": "weeklyMenu",
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
                        if !temp.menus.contains("weeklyMenu"){
                            temp.menus.append("weeklyMenu")
                        }
                        

                    }
                }
                
            }else{
                print("document does not exist")
            }
  
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.MenuListToMenu{
            if temp.mustReturnToMenuCreator{
                let destinationVC = segue.destination as! MenuCreator
                destinationVC.dayDict = self.dayDict
            }else{
                let destinationVC = segue.destination as! MenuCreator
                destinationVC.dayDict = self.dayDict
                destinationVC.menuName = menuName
            }
            
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
        if selectingWeeklyMenu || temp.mustReturnToMenuCreator{
            setAsWeeklyMenu(selectedMenu: menus[indexPath.row])
            
            
        } else{
            loadMenu(name: menus[indexPath.row])
        }
            
            
        
    }
    

    
    
}
