//
//  RegisterController.swift
//  mealMaker
//
//  Created by Isaac Mendelsohn on 11/19/20.
//

import UIKit
import Firebase
class LogInController: UIViewController {
    let db = Firestore.firestore()
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logInSelected(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text{
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    Alert.createAlert(title: "Error", message: e.localizedDescription, viewController: self)
                    
                }else{
                    print("trying to perform segue")
                    let userDoc = self.db.collection(K.FStore.userCollection).document(email)
                    userDoc.getDocument { (document, error) in
                        if let document = document, document.exists{
                            if let fam = document.data()?["families"] as? [String]{
                                temp.allFamilies = fam
                            }
                            
                        }else{
                            print("document does not exist")
                        }
                        temp.currentUser = email
                        self.performSegue(withIdentifier: K.Segues.logInToFamilies, sender: self)
                    }
                    
                }
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
