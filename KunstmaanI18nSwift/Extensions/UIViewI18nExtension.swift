//
//  UIViewExtension.swift
//  KunstmaanI18nSwift
//
//  Created by Daan Poron on 19/04/16.
//  Copyright © 2016 Kunstmaan. All rights reserved.
//

import Foundation

extension UIView  {
    
    internal class func swizzle() {
        for method in ["willMoveToWindow"] {
            let originalSelector = Selector("\(method):")
            let swizzledSelector = Selector("i18n_\(method):")
            
            Utils.swizzle(self, originalSelector, swizzledSelector)
        }
    }

    fileprivate struct AssociatedKeys {
        static var i18nKeys = "i18nKeys"
    }
    
    fileprivate func getI18nKeys() -> [String: String]? {
        
        return objc_getAssociatedObject(self, &AssociatedKeys.i18nKeys) as? [String: String]
    }
    
    public func i18n_willMoveToWindow(_ newWindow: UIWindow?) {
        self.i18n_willMoveToWindow(newWindow)
        
        if newWindow == nil {
            NotificationCenter.default.removeObserver(self, name: I18n.Events.onChange, object: nil)
        } else {
            NotificationCenter.default.addObserver(self, selector: #selector(UIView.updateTranslations), name: I18n.Events.onChange, object: nil)
            self.updateTranslations()
        }
    }
    
    public func updateTranslations() {
        if let i18nKeys = self.getI18nKeys() {
            for (type, key) in i18nKeys {
                self.update(i18nKey: key, forType: type)
            }
        }
    }
    
    internal func retrieveI18nKey(forType type: String) -> String? {
        return self.getI18nKeys()?[type]
    }
    
    internal func register(i18nKey key: String, forType type: String) {
        var keys = getI18nKeys()
        
        if keys == nil {
            keys = [String: String]()
        }
        
        keys![type] = key
        
        objc_setAssociatedObject(self, &AssociatedKeys.i18nKeys, keys!, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        self.update(i18nKey: key, forType: type)
    }
    
    internal func update(i18nKey key: String, forType type: String) { /* Should be overriden */ }
    
}
