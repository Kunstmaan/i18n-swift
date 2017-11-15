//
//  UIViewControllerExtension.swift
//  KunstmaanI18nSwift
//
//  Created by Daan Poron on 12/07/2017.
//  Copyright © 2017 Kunstmaan. All rights reserved.
//

import Foundation

extension UIViewController {
    
    @objc open var i18nTabKey: String? {
        
        return nil
    }
    
    @objc open var i18nNavKey: String? {
        
        return nil
    }
    
    internal class func swizzle() {
        let originalWillAppearSelector = #selector(self.viewWillAppear(_:))
        let swizzledWillAppearSelector = #selector(self.i18n_viewWillAppear(_:))
        Utils.swizzle(self, originalWillAppearSelector, swizzledWillAppearSelector)
        
        let originalDidDisappearrSelector = #selector(self.viewDidDisappear(_:))
        let swizzledDidDisappearSelector = #selector(self.i18n_viewDidDisappear(_:))
        Utils.swizzle(self, originalDidDisappearrSelector, swizzledDidDisappearSelector)
    }
    
    @objc func i18n_viewWillAppear(_ animated: Bool) {
        self.i18n_viewWillAppear(animated)
        
        self.updateTranslations()
        NotificationCenter.default.addObserver(self, selector: #selector(UITabBarController.updateTranslations), name: I18n.Events.onChange, object: nil)
    }
    
    @objc func i18n_viewDidDisappear(_ animated: Bool) {
        self.i18n_viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: I18n.Events.onChange, object: nil)
    }
    
    @objc open func updateTranslations() {
        if let i18nTabKey = self.i18nTabKey {
            self.tabBarItem?.title = I18n.localizedString(forKey: i18nTabKey)
        }
        
        if let i18nNavKey = self.i18nNavKey {
            self.navigationItem.title = I18n.localizedString(forKey: i18nNavKey)
        }
        
        if let navVC = self as? UINavigationController {
            for vc in navVC.viewControllers {
                if let i18nNavKey = vc.i18nNavKey {
                    vc.navigationItem.title = I18n.localizedString(forKey: i18nNavKey)
                }
            }
        }
        
        if let tabVC = self as? UITabBarController {
            if let viewControllers = tabVC.viewControllers {
                for vc in viewControllers {
                    if let i18nTabKey = vc.i18nTabKey {
                        vc.tabBarItem?.title = I18n.localizedString(forKey: i18nTabKey)
                    }
                }
            }
        }
    }
    
}
