//
//  UIViewExtension.swift
//  KunstmaanI18nSwift
//
//  Created by Daan Poron on 19/04/16.
//  Copyright © 2016 Kunstmaan. All rights reserved.
//

import Foundation

extension UIView  {
    
    internal static func swizzle() {
        for method in ["willMoveToWindow"] {
            let originalSelector = Selector("\(method):")
            let swizzledSelector = Selector("i18n_\(method):")
            
            let originalMethod = class_getInstanceMethod(self, originalSelector)
            let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
            
            let didAddMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
            
            if didAddMethod {
                class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod)
            }
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
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: I18n.Events.OnChange), object: nil)
        } else {
            NotificationCenter.default.addObserver(self, selector: #selector(UIView.updateTranslations), name: NSNotification.Name(rawValue: I18n.Events.OnChange), object: nil)
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
