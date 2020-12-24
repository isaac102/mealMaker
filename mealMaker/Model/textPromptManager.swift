//
//  textPromptManager.swift
//  mealMaker
//
//  Created by Isaac Mendelsohn on 11/23/20.
//

import Foundation
class textPromptManager{
    
    static func getView(title: String) -> textPromptView{
        let view = textPromptView()
        view.text.text = title
        
        view.heightAnchor.constraint(equalToConstant: 25).isActive = true
        view.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
        return view
    }
    
    static func getView(title: String, sample:String) -> textPromptView{
        let view = textPromptView()
        view.text.text = title
        view.textBox.placeholder = sample
        
        view.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        view.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
        return view
    }
    
    
}
