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
        get {
            return super.retrieveI18nKey("default")!
        }
        set {
            super.registerI18nKey("default", key: newValue)
        }
    }
    
    @IBInspectable
    public var i18nHighLightedTitleKey: String {
        get {
            return super.retrieveI18nKey("highlighted")!
        }
        set {
            super.registerI18nKey("highlighted", key: newValue)
        }
    }
    
    @IBInspectable
    public var i18nSelectedTitleKey: String {
        get {
            return super.retrieveI18nKey("selected")!
        }
        set {
            super.registerI18nKey("selected", key: newValue)
        }
    }
    
    @IBInspectable
    public var i18nDisabledTitleKey: String {
        get {
            return super.retrieveI18nKey("disabled")!
        }
        set {
            super.registerI18nKey("disabled", key: newValue)
        }
    }
    
    override internal func updateTranslation(_ type: String, key: String) {
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
        self.setTitle(I18n.localizedStringForKey(key, value: defaultValue), for: state)
    }
}
