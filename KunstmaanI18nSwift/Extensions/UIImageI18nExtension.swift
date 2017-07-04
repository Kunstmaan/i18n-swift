//
//  UIImageL18nExtension.swift
//  KunstmaanI18nSwift
//
//  Created by Daan Poron on 21/03/16.
//  Copyright © 2016 Kunstmaan. All rights reserved.
//

import UIKit

@IBDesignable
public extension UIImageView {
    
    @IBInspectable
    public var i18nImageBaseName: String? {
        get {
            return super.retrieveI18nKey("baseName")!
        }
        set(baseName) {
            if let baseName = baseName {
                self.registerI18nKey("baseName", key: baseName)
            }
        }
    }
    
    override internal func updateTranslation(_ type: String, key: String) {
        switch type {
        case "baseName":
            if let img = I18n.localizedImageForName(key) {
                self.image = img
            }
            break
        default:
            break
        }
    }
    
}
