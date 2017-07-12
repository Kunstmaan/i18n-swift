//
//  Swizzle.swift
//  KunstmaanI18nSwift
//
//  Created by Daan Poron on 12/07/2017.
//  Copyright © 2017 Kunstmaan. All rights reserved.
//

import Foundation

internal class Utils {
    
    internal static let swizzle: (AnyClass, Selector, Selector) -> () = { forClass, originalSelector, swizzledSelector in
        let originalMethod = class_getInstanceMethod(forClass, originalSelector)
        let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector)
        
        let didAddMethod = class_addMethod(forClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
        
        if didAddMethod {
            class_replaceMethod(forClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
    
}
