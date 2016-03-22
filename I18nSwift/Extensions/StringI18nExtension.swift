//
//  StringI18nExtension.swift
//  I18nSwift
//
//  Created by Daan Poron on 21/03/16.
//  Copyright © 2016 Kunstmaan. All rights reserved.
//

import UIKit

public extension String {
    
    public var i18nLocalized: String {
        get {
            return I18n.instance.localizedStringForKey(self)
        }
    }
    
    public func i18nLocalized(value: String? = nil, table: String? = nil, arguments: CVarArgType...) -> String {
        return I18n.instance.localizedStringForKey(self, value: value, table: table, arguments: arguments)
    }
    
}