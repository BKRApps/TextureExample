//
//  SwTextNodeAttributedTextBuilder.swift
//  TextureExampleProject
//
//  Created by kumar reddy on 18/04/19.
//  Copyright © 2019 kumar reddy. All rights reserved.
//

import Foundation
import AsyncDisplayKit

final class SwTextNodeAttributedTextBuilder {
    private let inputText: String
    private weak var textNode: ASTextNode?
    private var attributes = [NSAttributedString.Key: Any]()
    private var lineHeight: CGFloat?
    private var attributedText: NSMutableAttributedString!
    
    init(text: String, textNode: ASTextNode) {
        self.inputText = text
        self.textNode = textNode
        self.attributedText = NSMutableAttributedString(string: text)
    }
    
    func set(font: UIFont, for texts: [String]? = nil) -> SwTextNodeAttributedTextBuilder {
        _ = getRanges(texts: texts).map { attributedText.addAttributes([NSAttributedString.Key.font: font], range: $0)}
        return self
    }
    
    func set(font: UIFont, textColor: UIColor, for texts: [String]? = nil) -> SwTextNodeAttributedTextBuilder {
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: textColor]
        _ = getRanges(texts: texts).map { attributedText.addAttributes(attributes, range: $0)}
        return self
    }
    
    func set(font: UIFont, textColor: UIColor, baselineOffset: CGFloat, for texts: [String]? = nil) -> SwTextNodeAttributedTextBuilder {
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: textColor, NSAttributedString.Key.baselineOffset: baselineOffset]
        _ = getRanges(texts: texts).map { attributedText.addAttributes(attributes, range: $0)}
        return self
    }
    
    func set(attributes: [NSAttributedString.Key: Any], for texts: [String]? = nil) -> SwTextNodeAttributedTextBuilder {
        _ = getRanges(texts: texts).map { attributedText.addAttributes(attributes, range: $0)}
        return self
    }
    
    func set(lineHeight: CGFloat = 1, characterSpacing: CGFloat = 0) -> SwTextNodeAttributedTextBuilder {
        self.lineHeight = lineHeight
        attributes[NSAttributedString.Key.kern] = characterSpacing
        return self
    }
}

extension SwTextNodeAttributedTextBuilder {
    private func getRanges(texts: [String]?) -> [NSRange] {
        guard let texts = texts else {
            return [NSRange(location: 0, length: attributedText.length)]
        }
        var ranges = [NSRange]()
        for text in texts {
            if let range = inputText.range(of: text) {
                let nsRange = NSRange(range, in: inputText)
                ranges.append(nsRange)
            }
        }
        return ranges
    }
}

extension SwTextNodeAttributedTextBuilder {
    func build() {
        let parahraphStyle = NSMutableParagraphStyle.init()
        parahraphStyle.lineHeightMultiple = self.lineHeight ?? 1.0
        //parahraphStyle.lineBreakMode = self.textNode?.view.line.lineBreakMode ?? NSLineBreakMode.byTruncatingTail
        //parahraphStyle.alignment = self.textNode?.textAlignment ?? NSTextAlignment.left
        attributes[NSAttributedString.Key.paragraphStyle] = parahraphStyle
        attributedText.addAttributes(attributes, range: NSRange(location: 0, length: attributedText.length))
        self.textNode?.attributedText = attributedText
    }
}
