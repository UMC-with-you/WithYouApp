//
//  Extension + UILabel.swift
//  WithYou
//
//  Created by 김도경 on 1/12/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit

extension UILabel {
    public func setLineSpacing(spacing : CGFloat){
        guard let text = text else { return }
        
        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = spacing
        attributeString.addAttribute(.paragraphStyle,
                                     value: style,
                                     range: NSRange(location: 0, length: attributeString.length))
        attributedText = attributeString
    }
}

extension UILabel {
    /* 텍스트 구간 폰트 변경 */
    func setFont(_ font: UIFont, range: NSRange) {
        guard let attributedString = self.mutableAttributedString() else { return }
        
        attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: range)
        self.attributedText = attributedString
    }
    
    /* 텍스트 구간 볼드 폰트 변경 */
    func setBoldFont(_ boldFontName: String, range: NSRange) {
        guard let font = self.font,
              let boldFont = UIFont(name: boldFontName, size: font.pointSize) else {
            return
        }
        
        return setFont(boldFont, range: range)
    }
    
    /* AttributedString이 설정되어있지 않으면 생성하여 반환한다. */
    private func mutableAttributedString() -> NSMutableAttributedString? {
        guard let labelText = self.text, let labelFont = self.font else { return nil }
        
        var attributedString: NSMutableAttributedString?
        if let attributedText = self.attributedText {
            attributedString = attributedText.mutableCopy() as? NSMutableAttributedString
        } else {
            attributedString = NSMutableAttributedString(string: labelText,
                                                         attributes: [NSAttributedString.Key.font :labelFont])
        }
        
        return attributedString
    }
}

