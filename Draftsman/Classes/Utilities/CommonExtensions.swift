//
//  CommonExtensions.swift
//  Draftsman
//
//  Created by Nayanda Haberty on 19/02/21.
//

import Foundation
#if canImport(UIKit)
import UIKit

infix operator =~

extension String {
    func camelCaseToSnakeCase() -> String {
        let acronymPattern = "([A-Z]+)([A-Z][a-z]|[0-9])"
        let normalPattern = "([a-z0-9])([A-Z])"
        return self.processCamelCase(pattern: acronymPattern)?
            .processCamelCase(pattern: normalPattern)?.lowercased() ?? self.lowercased()
    }
    
    func processCamelCase(pattern: String) -> String? {
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: count)
        return regex?.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "$1_$2")
    }
    
    public static func randomString(length: Int = 9) -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        var randomString = ""
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        return randomString
    }
    
    static func =~ (_ text: String, pattern: String) -> Bool {
        return text.range(of: pattern, options: .regularExpression, range: nil, locale: nil) != nil
    }
}

public extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

public extension NSObject {
    var uniqueKey: String {
        let address = Int(bitPattern: Unmanaged.passUnretained(self).toOpaque())
        return NSString(format: "%p", address) as String
    }
}

public extension UIResponder {
    @available(*, renamed: "parentViewController")
    var nextViewController: UIViewController? {
        next as? UIViewController ?? next?.nextViewController
    }
}
#endif
