//
//  UIButtonL18nExtension.swift
//  KunstmaanI18nSwift
//
//  Created by Daan Poron on 21/03/16.
//  Copyright © 2016 Kunstmaan. All rights reserved.
//

import UIKit

@IBDesignable
public extension UIButton {
    
    @IBInspectable
    public var i18nDefaultTitleKey: String {
        get { return "" }
        set {
            let defaultValue = self.titleForState(.Normal)
            self.setTitle(I18n.localizedStringForKey(newValue, value: defaultValue), forState: .Normal)
        }
    }
    
    @IBInspectable
    public var i18nHighLightedTitleKey: String {
        get { return "" }
        set {
            let defaultValue = self.titleForState(.Normal)
            self.setTitle(I18n.localizedStringForKey(newValue, value: defaultValue), forState: .Highlighted)
        }
    }
    
    @IBInspectable
    public var i18nSelectedTitleKey: String {
        get { return "" }
        set {
            let defaultValue = self.titleForState(.Normal)
            self.setTitle(I18n.localizedStringForKey(newValue, value: defaultValue), forState: .Selected)
        }
    }
    
    @IBInspectable
    public var i18nDisabledTitleKey: String {
        get { return "" }
        set {
            let defaultValue = self.titleForState(.Normal)
            self.setTitle(I18n.localizedStringForKey(newValue, value: defaultValue), forState: .Disabled)
        }
    }
}