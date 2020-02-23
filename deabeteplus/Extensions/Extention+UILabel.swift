//
//  Extention+UILabel.swift
//  deabeteplus
//
//  Created by Ji Ra on 1/12/2562 BE.
//  Copyright © 2562 Ji Ra. All rights reserved.
//

import UIKit

extension UILabel {
    func getExistAttributedStyle() -> [NSAttributedString.Key: Any]? {
        guard let existAttr = self.attributedText?.attributes(at: 0, effectiveRange: nil) else {
            return nil
        }
        return existAttr
    }

    func setAttributedTextFromExistStyle(_ textValue: String?) {
        guard let txt = textValue else { return }
        guard let existAttr = getExistAttributedStyle() else {
            self.text = txt
            return
        }
        let attr = NSAttributedString(string: txt, attributes: existAttr)
        self.attributedText = attr
    }

    func setAttributedTextFromExistStyle(_ textValue: NSAttributedString?) {
        guard let txt = textValue else { return }
        guard let existAttr = getExistAttributedStyle() else {
            self.attributedText = txt
            return
        }
        let attr = NSMutableAttributedString(attributedString: txt)
        attr.setAttributes(existAttr, range: NSRange(location: 0, length: txt.length))
        self.attributedText = attr
    }
    
    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
        
        guard let labelText = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        
        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    }
}
