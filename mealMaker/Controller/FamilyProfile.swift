//
//  FamilyProfile.swift
//  mealMaker
//
//  Created by Isaac Mendelsohn on 12/28/20.
//

import Foundation
import UIKit
import Firebase
class FamilyProfile: UIViewController{
    let db = Firestore.firestore()
    @IBOutlet weak var passwordtext: UILabel!
    @IBOutlet weak var adminUsersText: UILabel!
    @IBOutlet weak var nonAdminUsersText: UILabel!
    @IBOutlet weak var familyName: UILabel!
    
    var adminUsers = ""
    var noAdminUsers = ""
    
    
    override func viewDidLoad() {
        //admin Users
        familyName.text = temp.currentFamily
        db.collection(K.FStore.familyCollection).document(K.FStore.familyDocument).collection(temp.currentFamily).document(K.FStore.adminUsersDocument).getDocument { (document, error) in
                if let document = document, document.exists{
                    if let adminUsers = document.data()?[K.FStore.adminUsersDocument] as? [String]{
                        for i in adminUsers{
                            
                            self.adminUsers += i
                            self.adminUsers += ", "
                        }
                        self.adminUsersText.text = self.adminUsers
                    }
                    
                }else{
                    print("document does not exist")
                }
        }
        //non admin Users
        db.collection(K.FStore.familyCollection).document(K.FStore.familyDocument).collection(temp.currentFamily).document(K.FStore.regularUsers).getDocument { (document, error) in
                if let document = document, document.exists{
                    if let regularUsers = document.data()?[K.FStore.regularUsers] as? [String]{
                        if regularUsers == [""]{
                            self.nonAdminUsersText.text = "NO NON ADMIN USERS"
                        }else{
                            for i in regularUsers{
                                self.noAdminUsers += i
                            }
                            self.nonAdminUsersText.text = self.noAdminUsers
                        }
                        
                    }
                    
                }else{
                    print("document does not exist")
                }
        }
        //password
        db.collection(K.FStore.familyCollection).document(K.FStore.familyDocument).collection(temp.currentFamily).document(K.FStore.passwordDocument).getDocument { (document, error) in
                if let document = document, document.exists{
                    if let password = document.data()?[K.FStore.passwordDocument]{
                        
                        self.passwordtext.text = "\(password)"

                    }
                    else{
                        print("for some reason there is no password????")
                    }
                    
                }else{
                    print("document does not exist")
                }
        }
    }
}
