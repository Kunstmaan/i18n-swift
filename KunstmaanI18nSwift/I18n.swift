//
//  I18n.swift
//  KunstmaanI18nSwift
//
//  Created by Daan Poron on 21/03/16.
//  Copyright © 2016 Kunstmaan. All rights reserved.
//

import Foundation

public enum I18nError: ErrorType {
    case InvalidLanguage
}

public class I18n: NSObject {
    
    public struct Events {
        
        public static let OnChange = "be.kunstmaan.i18n.events.on_change"
        
        private init() {}
        
    }
    
    // MARK: - Properties
    internal static var instance = I18n()
    
    // MARK: - Public Methods
    public static var possibleLanguages: [String] {
        get {
            var langs = NSBundle.mainBundle().localizations
            if let baseIndex = langs.indexOf("Base") { // remove base
                langs.removeAtIndex(baseIndex)
            }
            
            return langs
        }
    }
    
    public static var language: String? {
        get {
            return I18n.instance.lang
        }
    }
    
    public static var locale: NSLocale? {
        get {
            return I18n.instance.getLocale()
        }
    }
    
    public static var hasLanguage: Bool {
        get {
            return nil != I18n.instance.lang
        }
    }
    
    public static func setLanguage(lang: String) throws -> I18n.Type {
        try I18n.instance.setLanguage(lang)
        
        return I18n.self
    }
    
    public static func isCurrentLanguage(lang: String) -> Bool {
        return I18n.instance.isCurrentLanguage(lang)
    }
    
    public static func localizedStringForKey(key: String, value: String? = nil, table: String? = nil, arguments: CVarArgType...) -> String {
        return I18n.instance.localizedStringForKey(key, value: value, table: table, arguments: arguments)
    }
    
    public static func localizedImageForName(name: String) -> UIImage? {
        return I18n.instance.localizedImageForName(name)
    }
    
    public static func clear() -> I18n.Type {
        I18n.instance.clear()
        
        return I18n.self
    }
    
    // MARK: - Implementation
    private var lang: String?
    private var bundle: NSBundle
    
    private override init() {
        for lang in NSLocale.preferredLanguages() {
            let langComponents = NSLocale.componentsFromLocaleIdentifier(lang)
            
            if let langCode = langComponents[NSLocaleLanguageCode], let langBundle = getBundleForLanguage(langCode) {
                self.lang = langCode
                self.bundle = langBundle
                
                super.init()
                return
            }
        }
        
        self.lang = nil
        self.bundle = NSBundle.mainBundle()
        super.init()
    }
    
    public func setLanguage(lang: String) throws {
        if lang != self.lang {
            var userInfo = [
                "lang": lang
            ]
            
            if let oldLang = self.lang {
                userInfo["oldLang"] = oldLang
            }
            
            if let langBundle = getBundleForLanguage(lang) {
                self.lang = lang
                self.bundle = langBundle
                NSNotificationCenter.defaultCenter().postNotificationName(I18n.Events.OnChange, object: nil, userInfo: userInfo)
            } else {
                throw I18nError.InvalidLanguage
            }
        }
    }
    
    public func isCurrentLanguage(lang: String) -> Bool {
        return lang == self.lang
    }
    
    public func getLocale() -> NSLocale? {
        return self.lang != nil ? NSLocale(localeIdentifier: self.lang!) : nil
    }
    
    public func localizedStringForKey(key: String, value: String? = nil, table: String? = nil, arguments: CVarArgType...) -> String {
        return self.localizedStringForKey(key, value: value, table: table, arguments: arguments)
    }
    
    public func localizedStringForKey(key: String, value: String? = nil, table: String? = nil, arguments: [CVarArgType]) -> String {
        let translatedString = self.bundle.localizedStringForKey(key.lowercaseString, value: value, table: table)
        
        if arguments.isEmpty {
            return translatedString
        }
        
        return String(format: translatedString, arguments: arguments)
    }
    
    public func localizedImageForName(name: String) -> UIImage? {
        if !name.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()).isEmpty {
            return UIImage(named: self.localizedImageNameFor(name, lang: self.lang?.lowercaseString))
        }
        
        return nil
    }
    
    public func localizedImageNameFor(name: String, lang: String?) -> String {
        return "\(name)\(lang != nil ? " \(lang)" : ""))"
    }
    
    public func clear() {
        self.lang = nil
        self.bundle = NSBundle.mainBundle()
    }
    
}

private func getBundleForLanguage(lang: String) -> NSBundle? {
    if let path = NSBundle.mainBundle().pathForResource(lang, ofType: "lproj"), let bundle = NSBundle(path: path) {
        return bundle
    }
    
    return nil
}
