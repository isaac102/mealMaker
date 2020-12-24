//
//  Alert.swift
//  mealMaker
//
//  Created by Isaac Mendelsohn on 11/19/20.
//

import UIKit
class Alert{
    static func createAlert(title:String, message:String, viewController:UIViewController){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func createAlert(title:String, message:String, textPlaceholder:String){
        
        
        
        
    }
}
