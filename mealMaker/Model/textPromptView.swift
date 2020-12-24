//
//  textPromptView.swift
//  mealMaker
//
//  Created by Isaac Mendelsohn on 11/23/20.
//

import UIKit
//@IBDesignable
class textPromptView: UIView {

    @IBOutlet var textPromptView: UIView!
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var textBox: UITextField!
    
    let nibName = "textPromptView"
    var contentView:UIView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
