//
//  KakaoFriendDisplayNode.swift
//  TextureProject
//
//  Created by 황지은 on 2021/09/08.
//

import AsyncDisplayKit

class KakaoFriendHeaderNode: ASDisplayNode {
    
    let specNode = ASDisplayNode()
    
    let titleLabelNode: ASTextNode = {
        let node = ASTextNode()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        node.attributedText = NSAttributedString(
            string: "친구",
            attributes: [
                .font: UIFont(name: "AppleSDGothicNeoSB00", size: 22) ?? UIFont.systemFont(ofSize: 22),
                .foregroundColor: UIColor.black,
                .paragraphStyle: paragraphStyle
            ]
        )
        return node
    }()
    
    let settingButtonNode: ASButtonNode = {
        let node = ASButtonNode()
        node.setImage(UIImage(named: "settingIcon"), for: .normal)
        return node
    }()
    
    // MARK: Initializing
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
    }
    
    
    // MARK: Node Life Cycle
    override func layout() {
        super.layout()
    }
    
    
    // MARK: Layout
    override func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 15, left: 14, bottom: 16, right: 15),
            child: headerStackLayoutSpec()
        )
    }
    
    private func headerStackLayoutSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec (
            direction: .horizontal,
            spacing: 0.0,
            justifyContent: .spaceBetween,
            alignItems: .start,
            children: [
                titleLabelNode,
                settingButtonNode
            ])
    }
}
