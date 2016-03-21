//
//  UIImageL18nExtension.swift
//  I18nSwift
//
//  Created by Daan Poron on 21/03/16.
//  Copyright © 2016 Kunstmaan. All rights reserved.
//

import Foundation

@IBDesignable
public extension UIImageView {
    
    @IBInspectable
    var i18nImageBaseName: String? {
        get { return "" }
        set(baseName) {
            if let baseName = baseName, img = I18n.localizedImageForName(baseName) {
                self.image = img
            }
        }
    }
    
}