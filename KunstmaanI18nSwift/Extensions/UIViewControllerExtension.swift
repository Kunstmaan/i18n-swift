//
//  UIViewControllerExtension.swift
//  KunstmaanI18nSwift
//
//  Created by Daan Poron on 12/07/2017.
//  Copyright © 2017 Kunstmaan. All rights reserved.
//

import Foundation

extension UIViewController {
    
    open var i18nTabKey: String? {
        
        return nil
    }
    
    open var i18nNavKey: String? {
        
        return nil
    }
    
    internal class func swizzle() {
        let originalWillAppearSelector = #selector(self.viewWillAppear(_:))
        let swizzledWillAppearSelector = #selector(self.i18n_viewWillAppear(_:))
        Utils.swizzle(self, originalWillAppearSelector, swizzledWillAppearSelector)
    }
    
    func i18n_viewWillAppear(_ animated: Bool) {
        self.i18n_viewWillAppear(animated)
        
        if let i18nTabKey = self.i18nTabKey {
            self.tabBarItem?.title = I18n.localizedString(forKey: i18nTabKey)
        }
        
        if let i18nNavKey = self.i18nNavKey {
            self.navigationItem.title = I18n.localizedString(forKey: i18nNavKey)
        }
    }
    
}
