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
            return super.retrieveI18nKey(forType: "title")!
        }
        set {
            self.register(i18nKey: newValue, forType: "title")
        }
    }
    
    override public func update(i18nKey key: String, forType type: String) {
        switch type {
        case "title":
            let navItem = self.topItem!
            navItem.title = self.localizedString(forKey: key, withFallback: navItem.title)
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
