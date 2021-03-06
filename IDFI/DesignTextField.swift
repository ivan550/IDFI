//
//  DesignTextField.swift
//  IDFI
//
//  Created by IvánMS on 28/06/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//

import UIKit
@IBDesignable
class DesignTextField: UITextField {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet{
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = (cornerRadius > 0)
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var bgColor: UIColor? {
        didSet{
            backgroundColor = bgColor
        }
    }
    @IBInspectable var borderColor: UIColor? {
        didSet{
            layer.borderColor = borderColor?.cgColor
        }
    }
    @IBInspectable var placeholderColor: UIColor? {
        didSet{
            let rawString = attributedPlaceholder?.string != nil ? attributedPlaceholder!.string 	: ""
            let att = NSAttributedString(string:rawString,
                                         attributes: [.foregroundColor : placeholderColor as Any])
            attributedPlaceholder = att
        }
    }
}
