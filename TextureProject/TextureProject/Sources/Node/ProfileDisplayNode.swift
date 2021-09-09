//
//  ProfileDisplayNode.swift
//  TextureProject
//
//  Created by 황지은 on 2021/09/08.
//

import AsyncDisplayKit

class ProfileDisplayNode: ASDisplayNode {

    let specNode = ASDisplayNode()
    
    let dismissButtonNode: ASButtonNode = {
        let node = ASButtonNode()
        node.setImage(UIImage(named: "profileCloseBtn"), for: .normal)
        return node
    }()
    
    let profileImageNode : ASImageNode = {
        let node = ASImageNode()
        node.style.width = ASDimension(unit: .points, value: 97)
        node.style.height = ASDimension(unit: .points, value: 96)
        return node
    }()
    
    let nicknameEditButtonNode = ASButtonNode()
    let nameNode = ASTextNode()
    let divisionNode : ASDisplayNode = {
        let node = ASDisplayNode()
        node.style.width = ASDimension(unit: .points, value: 1)
        node.style.height = ASDimension(unit: .points, value: 375)
        node.backgroundColor = .coolGrey
        return node
    }()
    
    init(profileImage: String, nickname: String, division: KakaoFriendVC.User) {
        super.init()
        automaticallyManagesSubnodes = true
        
        switch division {
        case .myProfile:
            nicknameEditButtonNode.isHidden = true
            
        case .friendProfile:
            nicknameEditButtonNode.isHidden = false
        }
        
        profileImageNode.image = UIImage(named: profileImage) 
        
        let attrs = [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeoR00", size: 18.0), NSAttributedString.Key.foregroundColor: UIColor.white]
        let nameString = NSAttributedString(string: nickname, attributes: attrs as [NSAttributedString.Key : Any])
        nameNode.attributedText = nameString
    }
    
    // MARK: Node Life Cycle
    override func layout() {
        super.layout()
    }
    
    // MARK: Layout
    override func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 470, left: 0, bottom: 0, right: 0),
            child: profileLayoutSpec()
        )
    }
    
    func dismissLayoutSpec() -> ASLayoutSpec {
        specNode.styled {
            $0.height = ASDimension(unit: .points, value: 14.0)
        }
        
        return ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 0.0,
            justifyContent: .start,
            alignItems: .stretch,
            children: [
                specNode,
                self.dismissButtonNode
            ]
        )
    }
    
    func profileLayoutSpec() -> ASLayoutSpec {
        
        return ASStackLayoutSpec(
            direction: .vertical,
            spacing: 8.0,
            justifyContent: .start,
            alignItems: .stretch,
            children: [
                self.profileImageNode,
                self.nameNode
            ]
        )
    }
    
    func dismissBetweenProfileLayoutSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 0.0,
            justifyContent: .start,
            alignItems: .stretch,
            children: [
                dismissLayoutSpec(),
                profileLayoutSpec()
            ]
        )
    }
    
    private func headerStackLayoutSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec (
            direction: .horizontal,
            spacing: 42.0,
            justifyContent: .start,
            alignItems: .start,
            children: [
                dismissBetweenProfileLayoutSpec(),
                divisionNode
            ])
    }
}
