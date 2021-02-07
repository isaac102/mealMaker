//
//  SetUpController.swift
//  mealMaker
//
//  Created by Isaac Mendelsohn on 11/19/20.
//


import UIKit

class SetUpController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        print("view will apperar")
        if temp.currentUser != ""{
            print("families are \(temp.allFamilies)")
            self.performSegue(withIdentifier: K.Segues.SetUpToMenu, sender: self)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
