//
//  UILabelL18nExtension.swift
//  I18nSwift
//
//  Created by Daan Poron on 21/03/16.
//  Copyright © 2016 Kunstmaan. All rights reserved.
//

import UIKit

@IBDesignable
public extension UILabel {
    
    @IBInspectable
    public var i18nTextKey: String {
        get { return "" }
        set {
            let defaultValue = self.attributedText?.string ?? self.text
            let localizedValue = I18n.localizedStringForKey(newValue, value: defaultValue)
            
            if let attributedText = self.attributedText {
                self.attributedText = NSMutableAttributedString(string: localizedValue, attributes: attributedText.attributesAtIndex(0, effectiveRange: nil))
            } else {
                self.text = localizedValue
            }
        }
    }
    
}