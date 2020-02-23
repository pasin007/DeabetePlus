//
//  Extension+String.swift
//  deabeteplus
//
//  Created by Ji Ra on 1/12/2562 BE.
//  Copyright © 2562 Ji Ra. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var flag: String {
        guard !self.isEmpty else { return "🇺🇸" } // Default return US
        let countryCode = self.uppercased()
        guard Locale.isoRegionCodes.contains(countryCode) else { return "🏁" }
        var flag = ""
        for scarlar in countryCode.unicodeScalars {
            flag += String(UnicodeScalar(127397+scarlar.value)!)
        }
        return flag
    }

    var isEmoji: Bool {
        return self.unicodeScalars.contains{ $0.isEmoji }
    }
}

extension UnicodeScalar {
    var isEmoji: Bool {
        switch value {
        case 0x1F600...0x1F64F, // Emoticons
        0x1F300...0x1F5FF, // Misc Symbols and Pictographs
        0x1F680...0x1F6FF, // Transport and Map
        0x1F1E6...0x1F1FF, // Regional country flags
        0x2600...0x26FF,   // Misc symbols
        0x2700...0x27BF,   // Dingbats
        0xFE00...0xFE0F,   // Variation Selectors
        0x1F900...0x1F9FF,  // Supplemental Symbols and Pictographs
        127000...127600, // Various asian characters
        65024...65039, // Variation selector
        9100...9300, // Misc items
        8400...8447: // Combining Diacritical Marks for Symbols
            return true
        default: return false
        }
    }
}

extension String {
    var localizedCountryName: String {
        let countryCode = self.uppercased()
        guard Locale.isoRegionCodes.contains(countryCode) else { return self }
        return Locale(identifier: "en_US").localizedString(forRegionCode: countryCode) ?? self
    }
}

extension String {
    var trim: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var strike: NSAttributedString? {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSAttributedString.Key.underlineStyle.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }

}

extension String {
    var validateEmail: Bool {
        let emailRegEx = "^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: self)
    }
    
    func toDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss")-> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "th")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
    }
}


