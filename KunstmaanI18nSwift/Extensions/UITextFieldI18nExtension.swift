//
//  UITextViewL18nExtension.swift
//  KunstmaanI18nSwift
//
//  Created by Daan Poron on 21/03/16.
//  Copyright © 2016 Kunstmaan. All rights reserved.
//

import UIKit

@IBDesignable
public extension UITextField {
    
    @IBInspectable
    public var i18nPlaceholderKey: String {
        get {
            return super.retrieveI18nKey("placeholder")!
        }
        set {
            super.registerI18nKey("placeholder", key: newValue)
        }
    }
    
    override internal func updateTranslation(_ type: String, key: String) {
        switch type {
        case "placeholder":
            let defaultValue = self.attributedPlaceholder?.string ?? self.placeholder
            let localizedValue = I18n.localizedStringForKey(key, value: defaultValue)
            
            if let attributedPlaceholder = self.attributedPlaceholder {
                self.attributedPlaceholder = NSMutableAttributedString(string: localizedValue, attributes: attributedPlaceholder.attributes(at: 0, effectiveRange: nil))
            } else {
                self.placeholder = localizedValue
            }
            break
        default:
            break
        }
    }
    
}
