//
//  FamilyCreatorController.swift
//  mealMaker
//
//  Created by Isaac Mendelsohn on 12/21/20.
//

import Foundation
import UIKit
import Firebase
class FamilyCreatorController:UIViewController{
    let db = Firestore.firestore()
    
    @IBOutlet weak var joinFamilyName: UITextField!
    @IBOutlet weak var joinFamilyPassword: UITextField!
    @IBOutlet weak var createFamilyName: UITextField!
    @IBOutlet weak var createFamilyPassword: UITextField!
    
    
    
    @IBAction func goToJoinFamily(_ sender: UIButton) {
        if let family = joinFamilyName.text{
            db.collection(K.FStore.familyCollection).document(K.FStore.familyDocument).getDocument { (document, error) in
                if let document = document, document.exists{
                    if let fam = document.data()?["families"] as? [String]{
                        if (fam).contains(family){
                            self.db.collection(K.FStore.familyCollection).document(K.FStore.familyDocument).collection(family).document(K.FStore.passwordDocument).getDocument { (document, error) in
                                
                                if let document = document, document.exists{
                                    if let pass = document.data()?[K.FStore.passwordDocument]{
                                        if "\(pass)" == self.joinFamilyPassword.text{
                                            
                                            self.addUserToFamily(family: family)
                                            temp.currentFamily = family
                                            self.performSegue(withIdentifier: K.Segues.familyJoinToWelcome, sender: self)
                                            
                                        }else{
                                            Alert.createAlert(title: "Incorrect Password", message: "", viewController: self)
                                        }
                                    }
                                    
                                }else{
                                    print("document does not exist")
                                }
                            }
                        }else{
                            Alert.createAlert(title: "This family does not exist", message: "", viewController: self)
                        }
                    }
                        
                }
            }
            
            
        }else{
            Alert.createAlert(title: "Please type family name", message: "", viewController: self)
        }
        
    }
    
    func addUserToFamily(family:String){
        db.collection(K.FStore.userCollection).document(temp.currentUser).updateData([
            "families" : FieldValue.arrayUnion([family])
        ])
        db.collection(K.FStore.familyCollection).document(K.FStore.familyDocument).collection(family).document(K.FStore.regularUsers).updateData([K.FStore.regularUsers : FieldValue.arrayUnion([temp.currentUser])])
        temp.allFamilies.append(family)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.familyJoinToWelcome{
            let destinationVC = segue.destination as! WelcomeController
            destinationVC.navigationItem.hidesBackButton = true
        }
    }
    
    @IBAction func goToCreateFamily(_ sender: UIButton) {
        
        db.collection(K.FStore.familyCollection).document(K.FStore.familyDocument).getDocument { (document, error) in
            if let document = document, document.exists{
                
                if let fam = document.data(){
                    
                    if let newName: String = self.createFamilyName.text{
                        
                        let preFam = fam["families"] as! [String]
                        
                        if preFam.contains(newName){
                            Alert.createAlert(title: "This Family Already Exists", message: "", viewController: self)
                            return
                        }else{
                            if let newPassword = self.createFamilyPassword.text{
                                if newPassword == ""{
                                    Alert.createAlert(title: "Please add a password", message: "", viewController: self)
                                    return
                                }
                                
                                let password = newPassword
                                
    //                            self.db.collection(K.FStore.familyCollection).document(K.FStore.familyDocument).collection(newName).document(K.FStore.dishCollection).collection(K.FStore.dishCollection)
                                FoodStorage.createSampleDish(familyName: newName)
                                print("HERE>>>>>>>>>>>>>>>>>")
                                self.db.collection(K.FStore.familyCollection).document(K.FStore.familyDocument).updateData([
                                    "families" : FieldValue.arrayUnion([newName])
                                ])
                                self.db.collection(K.FStore.userCollection).document(temp.currentUser)
                                    .updateData([
                                                    "families" : FieldValue.arrayUnion([newName])
                                    ])
                                self.db.collection(K.FStore.familyCollection).document(K.FStore.familyDocument).collection(newName).document(K.FStore.passwordDocument).setData([K.FStore.passwordDocument: password])
                                self.db.collection(K.FStore.familyCollection).document(K.FStore.familyDocument).collection(newName).document(K.FStore.adminUsersDocument).setData([K.FStore.adminUsersDocument: ["\(temp.currentUser)"]])
                                self.db.collection(K.FStore.familyCollection).document(K.FStore.familyDocument).collection(newName).document(K.FStore.regularUsers).setData([K.FStore.regularUsers: [""]])
                                print("HERE<<<<<<<<<<<<<<<<<<<<<")
                                temp.currentFamily = newName
                                self.performSegue(withIdentifier: K.Segues.familyJoinToWelcome, sender: self)
                            }
                            
                        }
                        
                        

                    }else{
                        Alert.createAlert(title: "Please Type Family Name", message: "", viewController: self)
                        return
                    }
                    
                    
                }
                
            }else{
                print("document does not exist")
            }
        }
    }
}
