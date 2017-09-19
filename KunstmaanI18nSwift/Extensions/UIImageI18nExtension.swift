//
//  UIImageL18nExtension.swift
//  KunstmaanI18nSwift
//
//  Created by Daan Poron on 21/03/16.
//  Copyright © 2016 Kunstmaan. All rights reserved.
//

import UIKit

@IBDesignable
extension UIImageView {
    
    @IBInspectable
    public var i18nImageBaseName: String? {
        get {
            return super.retrieveI18nKey(forType: "baseName")!
        }
        set(baseName) {
            if let baseName = baseName {
                self.register(i18nKey: baseName, forType: "baseName")
            }
        }
    }
    
    override open func update(i18nKey key: String, forType type: String) {
        switch type {
        case "baseName":
            if let img = I18n.localizedImage(forName: key) {
                self.image = img
            }
            break
        default:
            break
        }
    }
    
}
