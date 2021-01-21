//
//  LocalizationServices.swift
//  omdbMovieChallenge
//
//  Created by *_* on 1/21/21.
//

import Foundation

public protocol Localizable {
    var localized: String { get }
}

public func LILocalizedString(_ key: String, tableName: String? = nil, bundle: Bundle = Bundle.main, value: String = "", comment: String) -> String {
    return key.localizeWithComment(comment: comment)
}

extension String: Localizable {
    public var localized: String {
        return self.localizeWithComment(comment: "")
    }
    public func localizeWithComment(comment: String) -> String {
    
        var localizedString = NSLocalizedString(self, comment: comment)
        if self != localizedString {
            return localizedString
        }
        var bundleForString: Bundle
        if let path = Bundle.main.path(forResource: "Base", ofType: "lproj"),
            let bundle = Bundle(path: path) {
            bundleForString = bundle
        } else {
            bundleForString = Bundle.main
        }
        localizedString = bundleForString.localizedString(forKey: self, value: self, table: nil)
        return localizedString
    }
}
