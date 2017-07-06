//
//  StringI18nExtension.swift
//  KunstmaanI18nSwift
//
//  Created by Daan Poron on 21/03/16.
//  Copyright © 2016 Kunstmaan. All rights reserved.
//

import UIKit

public extension String {
    
    public var i18nLocalized: String {
        get {
            
            return I18n.instance.localizedString(forKey: self)
        }
    }
    
    public func i18nLocalized(withFallback fallbackValue: String? = nil, withTable table: String? = nil, arguments: CVarArg...) -> String {
        
        return I18n.instance.localizedString(forKey: self, withFallback: fallbackValue, table: table, arguments: arguments)
    }
    
}
