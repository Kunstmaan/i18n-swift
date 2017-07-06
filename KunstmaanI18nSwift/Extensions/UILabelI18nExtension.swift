//
//  UILabelL18nExtension.swift
//  KunstmaanI18nSwift
//
//  Created by Daan Poron on 21/03/16.
//  Copyright © 2016 Kunstmaan. All rights reserved.
//

import UIKit

@IBDesignable
public extension UILabel {
    
    @IBInspectable
    public var i18nTextKey: String {
        get {
            return super.retrieveI18nKey(forType: "text")!
        }
        set {
            super.register(i18nKey: newValue, forType: "text")
        }
    }
    
    override internal func update(i18nKey key: String, forType type: String) {
        switch type {
        case "text":
            let defaultValue = self.attributedText?.string ?? self.text
            let localizedValue = I18n.localizedString(forKey: key, withFallback: defaultValue)
            
            if let attributedText = self.attributedText {
                self.attributedText = NSMutableAttributedString(string: localizedValue, attributes: attributedText.attributes(at: 0, effectiveRange: nil))
            } else {
                self.text = localizedValue
            }
            break
        default:
            break
        }
    }
    
}
