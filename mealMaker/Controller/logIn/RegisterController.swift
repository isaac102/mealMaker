//
//  LogInController.swift
//  mealMaker
//
//  Created by Isaac Mendelsohn on 11/19/20.
//

import UIKit
import Firebase
class RegisterController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerSelected(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text{
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    Alert.createAlert(title: "Error", message: e.localizedDescription, viewController: self)
                    
                }else{
                    
                    self.db.collection(K.FStore.userCollection).document(email).setData([
                        "email": email,
                        "families": []
                    ]) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                            
                        }
                    }
                    temp.currentUser = email
                    
                    
                    
                    self.performSegue(withIdentifier: K.Segues.registerToFamilyJoin, sender: self)
                }
            }
        }else{
            Alert.createAlert(title: "Error", message: "Please fill in all fields", viewController: self)
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
