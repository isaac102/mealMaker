//
//  ItemDetail.swift
//  mealMaker
//
//  Created by Isaac Mendelsohn on 11/24/20.
//

import Foundation
import UIKit

class ItemDetail: UIViewController{
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var itemTextBox: UITextView!
    
    
    var itemName = ""
    
    override func viewDidLoad() {
        itemLabel.text = itemName
        //itemTextBox.placeholder = "Type \(itemName) Here"
        switch itemName {
        case "Directions":
            itemTextBox.text = temp.itemSpecifics.itemSpecificDirections
        case "Notes":
            itemTextBox.text = temp.itemSpecifics.itemSpecificNotes
        default:
            itemTextBox.text = ""
        }
        if !temp.editDishMode{
            itemTextBox.isUserInteractionEnabled = false
        }else{
            itemTextBox.isUserInteractionEnabled = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        switch itemName {
        case "Directions":
            temp.itemSpecifics.itemSpecificDirections = itemTextBox.text
        case "Notes":
            temp.itemSpecifics.itemSpecificNotes = itemTextBox.text
        default:
            itemTextBox.text = ""
        }
    }
}
