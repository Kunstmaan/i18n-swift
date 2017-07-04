//
//  I18n.swift
//  KunstmaanI18nSwift
//
//  Created by Daan Poron on 21/03/16.
//  Copyright © 2016 Kunstmaan. All rights reserved.
//

import Foundation

public enum I18nError: Error {
    case invalidLanguage
}

open class I18n: NSObject {
    
    public struct Events {
        
        public static let OnChange = "be.kunstmaan.i18n.events.on_change"
        
        fileprivate init() {}
        
    }
    
    // MARK: - Properties
    internal static let instance = I18n()
    
    // MARK: - Public Methods
    open class var possibleLanguages: [String] {
        get {
            var langs = Bundle.main.localizations
            if let baseIndex = langs.index(of: "Base") { // remove base
                langs.remove(at: baseIndex)
            }
            
            return langs
        }
    }
    
    open class var language: String? {
        get {
            return I18n.instance.lang
        }
    }
    
    open class var locale: Locale? {
        get {
            return I18n.instance.getLocale()
        }
    }
    
    open class var hasLanguage: Bool {
        get {
            return nil != I18n.instance.lang
        }
    }
    
    open class func setLanguage(_ lang: String) throws -> I18n.Type {
        try I18n.instance.setLanguage(lang)
        
        return I18n.self
    }
    
    open class func isCurrentLanguage(_ lang: String) -> Bool {
        return I18n.instance.isCurrentLanguage(lang)
    }
    
    open class func localizedStringForKey(_ key: String, value: String? = nil, table: String? = nil, arguments: CVarArg...) -> String {
        return I18n.instance.localizedStringForKey(key, value: value, table: table, arguments: arguments)
    }
    
    open class func localizedImageForName(_ name: String) -> UIImage? {
        return I18n.instance.localizedImageForName(name)
    }
    
    open class func clear() -> I18n.Type {
        I18n.instance.clear()
        
        return I18n.self
    }
    
    // MARK: - Implementation
    fileprivate var lang: String?
    fileprivate var bundle: Bundle
    
    fileprivate override init() {
        UIView.swizzle()
        
        for lang in Locale.preferredLanguages {
            let langComponents = Locale.components(fromIdentifier: lang)
            
            if let langCode = langComponents[String(describing: NSLocale.Key.languageCode)], let langBundle = getBundleForLanguage(langCode) {
                self.lang = langCode
                self.bundle = langBundle
                
                super.init()
                return
            }
        }
        
        self.lang = nil
        self.bundle = Bundle.main
        super.init()
    }
    
    open func setLanguage(_ lang: String) throws {
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
                NotificationCenter.default.post(name: Notification.Name(rawValue: I18n.Events.OnChange), object: nil, userInfo: userInfo)
            } else {
                throw I18nError.invalidLanguage
            }
        }
    }
    
    open func isCurrentLanguage(_ lang: String) -> Bool {
        return lang == self.lang
    }
    
    open func getLocale() -> Locale? {
        return self.lang != nil ? Locale(identifier: self.lang!) : nil
    }
    
    open func localizedStringForKey(_ key: String, value: String? = nil, table: String? = nil, arguments: CVarArg...) -> String {
        return self.localizedStringForKey(key, value: value, table: table, arguments: arguments)
    }
    
    open func localizedStringForKey(_ key: String, value: String? = nil, table: String? = nil, arguments: [CVarArg]) -> String {
        let translatedString = self.bundle.localizedString(forKey: key.lowercased(), value: value, table: table)
        
        if arguments.isEmpty {
            return translatedString
        }
        
        return String(format: translatedString, arguments: arguments)
    }
    
    open func localizedImageForName(_ name: String) -> UIImage? {
        if !name.trimmingCharacters(in: CharacterSet.whitespaces).isEmpty {
            return UIImage(named: self.localizedImageNameFor(name, lang: self.lang?.lowercased()))
        }
        
        return nil
    }
    
    open func localizedImageNameFor(_ name: String, lang: String?) -> String {
        return "\(name)\(lang != nil ? " (\(lang!))" : "")"
    }
    
    open func clear() {
        self.lang = nil
        self.bundle = Bundle.main
    }
    
}

private func getBundleForLanguage(_ lang: String) -> Bundle? {
    if let path = Bundle.main.path(forResource: lang, ofType: "lproj"), let bundle = Bundle(path: path) {
        return bundle
    }
    
    return nil
}
