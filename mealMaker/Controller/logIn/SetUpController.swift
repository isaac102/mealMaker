//
//  SetUpController.swift
//  mealMaker
//
//  Created by Isaac Mendelsohn on 11/19/20.
//


import UIKit

class SetUpController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        
        if temp.currentUser != ""{
            
            self.performSegue(withIdentifier: K.Segues.SetUpToMenu, sender: self)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
