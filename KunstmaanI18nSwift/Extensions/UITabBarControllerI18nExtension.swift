//
//  TabBarControllerI18nExtension.swift
//  Pods
//
//  Created by Daan Poron on 11/07/2017.
//
//

import Foundation

extension UITabBarController {

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.updateTranslations()
        NotificationCenter.default.addObserver(self, selector: #selector(UITabBarController.updateTranslations), name: I18n.Events.onChange, object: nil)
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: I18n.Events.onChange, object: nil)
    }
    
    @objc
    private func updateTranslations() {
        if let viewControllers = self.viewControllers {
            for vc in viewControllers {
                if let i18nTabKey = vc.i18nTabKey {
                    vc.tabBarItem?.title = I18n.localizedString(forKey: i18nTabKey)
                }
            }
        }
    }
}
