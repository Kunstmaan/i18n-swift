//
//  UITextViewL18nExtension.swift
//  I18nSwift
//
//  Created by Daan Poron on 21/03/16.
//  Copyright © 2016 Kunstmaan. All rights reserved.
//

import UIKit

@IBDesignable
public extension UITextField {
    
    @IBInspectable
    public var i18nPlaceholderKey: String {
        get { return "" }
        set {
            let defaultValue = self.attributedPlaceholder?.string ?? self.placeholder
            let localizedValue = I18n.localizedStringForKey(newValue, value: defaultValue)
            
            if let attributedPlaceholder = self.attributedPlaceholder {
                self.attributedPlaceholder = NSMutableAttributedString(string: localizedValue, attributes: attributedPlaceholder.attributesAtIndex(0, effectiveRange: nil))
            } else {
                self.placeholder = localizedValue
            }
        }
    }
}
