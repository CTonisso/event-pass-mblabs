//
//  EPTextField.swift
//  EventPass
//
//  Created by Carlos Marcelo Tonisso Junior on 4/3/19.
//  Copyright © 2019 Carlos Marcelo Tonisso Junior. All rights reserved.
//

import Foundation
import UIKit

class EPTextField: UITextField {
    
    var leftPadding: CGFloat = 0
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        
        let padding = UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: 0)
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        
        let padding = UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: 0)
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        
        let padding = UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: 0)
        return bounds.inset(by: padding)
    }
}
