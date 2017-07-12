//
//  NavigationControllerI18nExtension.swift
//  Pods
//
//  Created by Daan Poron on 11/07/2017.
//
//

import Foundation

extension UINavigationController {
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.updateTranslations()
        NotificationCenter.default.addObserver(self, selector: #selector(UINavigationController.updateTranslations), name: I18n.Events.onChange, object: nil)
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: I18n.Events.onChange, object: nil)
    }
    
    @objc
    private func updateTranslations() {
        for vc in self.viewControllers {
            if let i18nNavKey = vc.i18nNavKey {
                vc.navigationItem.title = I18n.localizedString(forKey: i18nNavKey)
            }
        }
    }
}
