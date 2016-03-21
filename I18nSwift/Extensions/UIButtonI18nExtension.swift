//
//  UIButtonL18nExtension.swift
//  I18nSwift
//
//  Created by Daan Poron on 21/03/16.
//  Copyright © 2016 Kunstmaan. All rights reserved.
//

import Foundation

@IBDesignable
public extension UIButton {
    
    @IBInspectable
    var i18nDefaultTitleKey: String {
        get { return "" }
        set {
            let defaultValue = self.titleForState(.Normal)
            self.setTitle(I18n.localizedStringForKey(newValue, value: defaultValue), forState: .Normal)
        }
    }
    
    @IBInspectable
    var i18nHighLightedTitleKey: String {
        get { return "" }
        set {
            let defaultValue = self.titleForState(.Normal)
            self.setTitle(I18n.localizedStringForKey(newValue, value: defaultValue), forState: .Highlighted)
        }
    }
    
    @IBInspectable
    var i18nSelectedTitleKey: String {
        get { return "" }
        set {
            let defaultValue = self.titleForState(.Normal)
            self.setTitle(I18n.localizedStringForKey(newValue, value: defaultValue), forState: .Selected)
        }
    }
    
    @IBInspectable
    var i18nDisabledTitleKey: String {
        get { return "" }
        set {
            let defaultValue = self.titleForState(.Normal)
            self.setTitle(I18n.localizedStringForKey(newValue, value: defaultValue), forState: .Disabled)
        }
    }
}