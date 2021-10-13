//
//  SettingTVCellNode.swift
//  Starbucks_Clone
//
//  Created by 황지은 on 2021/10/13.
//

import UIKit
import AsyncDisplayKit

class SettingTVCellNode: ASCellNode {
    
    let iconNode = ASImageNode()
    let descTextNode = ASTextNode()
    let onOffStateNode = ASTextNode()
    let nextBtnNode = ASImageNode()
    
    init(settingModel: PaySettingData) {
        super.init()
        automaticallyManagesSubnodes = true
        
        iconNode.image = UIImage(named: settingModel.icon)
        descTextNode.attributedText = setAttributedString(text: settingModel.settingName, fontStyle: "AppleSDGothicNeoM00", fontSize: 15.0, fontColor: UIColor.black)
    }
    
    // Attribute String 설정
    func setAttributedString(text: String, fontStyle: String, fontSize: CGFloat, fontColor: UIColor) -> NSAttributedString {
        let attrs = [NSAttributedString.Key.font: UIFont(name: fontStyle, size: fontSize), NSAttributedString.Key.foregroundColor: fontColor]
        let attrString = NSAttributedString(string: text, attributes: attrs as [NSAttributedString.Key : Any])
        
        return attrString
    }
}
//MARK: - Layout
extension SettingTVCellNode {
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let settingLayout = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 10.0,
            justifyContent: .start,
            alignItems: .start,
            children: [
                iconNode,
                descTextNode
            ]
        )
        
        return ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 0),
            child: settingLayout
        )
    }
}
