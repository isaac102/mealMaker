//
//  WelcomeController.swift
//  mealMaker
//
//  Created by Isaac Mendelsohn on 11/19/20.
//

import UIKit
import Firebase
class WelcomeController: UIViewController {
    @IBOutlet weak var familyProfileButton: UIButton!
    let db = Firestore.firestore()
    var dayDict: [Int:[String]] = [1:[], 2:[], 3:[], 4:[], 5:[]]
//    var fromFamController:Bool? = nil
    var selectWeeklyMenu = false
    var enteringWeeklyMenu = false
    
    override func viewWillAppear(_ animated: Bool) {
        selectWeeklyMenu = false
        enteringWeeklyMenu = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadFirebase.loadFirebase()
        
        familyProfileButton.setTitle("\(temp.currentFamily.prefix(1))", for: .normal)
        
        navigationItem.title = temp.currentFamily
        familyProfileButton.layer.cornerRadius = 0.5 * familyProfileButton.bounds.size.width
//        self.tabBarController?.navigationItem.hidesBackButton = fromFamController

        // Do any additional setup after loading the view.
    }
    
    @IBAction func thisWeeksMenuPressed(_ sender: Any) {
        if temp.menus.count == 0{
            Alert.createAlert(title: "Please create a menu first", message: "", viewController: self)
            return
        }
        if(!temp.menus.contains("weeklyMenu")){
            selectWeeklyMenu = true
            performSegue(withIdentifier: K.Segues.WelcomeToMenus, sender: self)
        }else{
            let menu = self.db.collection(K.FStore.familyCollection).document(K.FStore.familyDocument).collection(temp.currentFamily).document(K.FStore.menuDocument).collection(K.FStore.menuCollection).document("weeklyMenu")
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
                    self.enteringWeeklyMenu = true
                    self.performSegue(withIdentifier: K.Segues.welcomeToMenuCreator, sender: self)
                }else{
                    print("document does not exist")
                }
      
            }
        }
        
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
        do{
            try Auth.auth().signOut()
            temp.currentUser = ""
            self.navigationController?.popToRootViewController(animated: true)
        }catch let signOutError as NSError{
            Alert.createAlert(title: "Error", message: "Error signing out :\(signOutError)", viewController: self)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.WelcomeToMenus{
            let destinationVC = segue.destination as! MenuListController
            destinationVC.selectingWeeklyMenu = selectWeeklyMenu
        }else if segue.identifier == K.Segues.welcomeToMenuCreator{
            let destinationVC = segue.destination as! MenuCreator
            if enteringWeeklyMenu{
                destinationVC.dayDict = self.dayDict
                destinationVC.menuName = "weeklyMenu"
            }else{
                
                destinationVC.menuName = ""
                destinationVC.dayDict = [1:[], 2:[], 3:[], 4:[], 5:[]]
            }
            
        }


    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
