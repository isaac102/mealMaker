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
    
    
    
    @IBAction func goToJoinFamily(_ sender: UIButton) {
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
                            
                            let password = Int.random(in: 99999...999999)
                            
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
                            self.db.collection(K.FStore.familyCollection).document(K.FStore.familyDocument).collection(newName).document(K.FStore.passwordDocument).setData(["password": password])
                            print("HERE<<<<<<<<<<<<<<<<<<<<<")
                            temp.currentFamily = newName
                            self.performSegue(withIdentifier: K.Segues.familyJoinToWelcome, sender: self)
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
