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
            return super.retrieveI18nKey(forType: "placeholder")!
        }
        set {
            super.register(i18nKey: newValue, forType: "placeholder")
        }
    }
    
    override public func update(i18nKey key: String, forType type: String) {
        switch type {
        case "placeholder":
            let defaultValue = self.attributedPlaceholder?.string ?? self.placeholder
            let localizedValue = self.localizedString(forKey: key, withFallback: defaultValue)
            
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
