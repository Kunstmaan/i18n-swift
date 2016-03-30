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
        get { return "" }
        set(baseName) {
            if let baseName = baseName, img = I18n.localizedImageForName(baseName) {
                self.image = img
            }
        }
    }
    
}