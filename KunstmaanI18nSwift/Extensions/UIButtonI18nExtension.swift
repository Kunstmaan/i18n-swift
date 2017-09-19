//
//  UIButtonL18nExtension.swift
//  KunstmaanI18nSwift
//
//  Created by Daan Poron on 21/03/16.
//  Copyright © 2016 Kunstmaan. All rights reserved.
//

import UIKit

@IBDesignable
extension UIButton: I18nLocalizableDelegate {
    
    @IBInspectable
    public var i18nDefaultTitleKey: String {
        get {
            return super.retrieveI18nKey(forType: "default")!
        }
        set {
            self.i18nLocalizableDelegate = self
            super.register(i18nKey: newValue, forType: "default")
        }
    }
    
    @IBInspectable
    public var i18nHighLightedTitleKey: String {
        get {
            return super.retrieveI18nKey(forType: "highlighted")!
        }
        set {
            self.i18nLocalizableDelegate = self
            super.register(i18nKey: newValue, forType: "highlighted")
        }
    }
    
    @IBInspectable
    public var i18nSelectedTitleKey: String {
        get {
            return super.retrieveI18nKey(forType: "selected")!
        }
        set {
            self.i18nLocalizableDelegate = self
            super.register(i18nKey: newValue, forType: "selected")
        }
    }
    
    @IBInspectable
    public var i18nDisabledTitleKey: String {
        get {
            return super.retrieveI18nKey(forType: "disabled")!
        }
        set {
            self.i18nLocalizableDelegate = self
            super.register(i18nKey: newValue, forType: "disabled")
        }
    }
    
    public func update(i18nKey key: String, forType type: String) {
        let state: UIControlState
        
        switch type {
        case "highlighted":
            state = .highlighted
            break
        case "selected":
            state = .selected
            break
        case "disabled":
            state = .disabled
            break
        default:
            state = UIControlState()
            break
        }
        
        let defaultValue = self.title(for: UIControlState())
        self.setTitle(self.localizedString(forKey: key, withFallback: defaultValue), for: state)
    }
    
}
