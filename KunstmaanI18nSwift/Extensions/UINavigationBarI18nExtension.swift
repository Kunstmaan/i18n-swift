//
//  UINavigationItemI18nExtension.swift
//  KunstmaanI18nSwift
//
//  Created by Daan Poron on 21/03/16.
//  Copyright © 2016 Kunstmaan. All rights reserved.
//

import UIKit

@IBDesignable
public extension UINavigationBar {
    
    @IBInspectable
    public var i18nTitleKey: String {
        get {
            return super.retrieveI18nKey("title")!
        }
        set {
            self.registerI18nKey("title", key: newValue)
        }
    }
    
    override internal func updateTranslation(type: String, key: String) {
        switch type {
        case "title":
            let navItem = self.topItem!
            navItem.title = I18n.localizedStringForKey(key, value: navItem.title)
            break
        default:
            break
        }
    }
    
}

/*
This can't be done on navigation item, navigation item doesn't know when it's on the window ...
Maybe this can be done by always appending a titleView instead of setting the title
 
@IBDesignable
extension UINavigationItem {
    
    @IBInspectable
    var i18nTitleKey: String {
        get { return "" }
        set {
            let defaultValue = self.title
            self.title = I18n.localizedStringForKey(newValue, value: defaultValue)
        }
    }
    
}
*/