//
//  WelcomeController.swift
//  mealMaker
//
//  Created by Isaac Mendelsohn on 11/19/20.
//

import UIKit
import Firebase
class WelcomeController: UIViewController {
    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadFirebase.loadDishes()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
        do{
            try Auth.auth().signOut()
            self.navigationController?.popToRootViewController(animated: true)
        }catch let signOutError as NSError{
            Alert.createAlert(title: "Error", message: "Error signing out :\(signOutError)", viewController: self)
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
