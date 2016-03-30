//
//  UINavigationItemI18nExtension.swift
//  KunstmaanI18nSwift
//
//  Created by Daan Poron on 21/03/16.
//  Copyright © 2016 Kunstmaan. All rights reserved.
//

import UIKit

@IBDesignable
public extension UINavigationItem {
    
    @IBInspectable
    public var i18nTitleKey: String {
        get { return "" }
        set {
            let defaultValue = self.title
            self.title = I18n.localizedStringForKey(newValue, value: defaultValue)
        }
    }

}
