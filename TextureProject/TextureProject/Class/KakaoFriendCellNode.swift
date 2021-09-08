//
//  KakaoFriendCellNode.swift
//  TextureProject
//
//  Created by 황지은 on 2021/09/01.
//

import AsyncDisplayKit

class KakaoFriendCellNode: ASCellNode {
    
    let specNode = ASDisplayNode()
    
    let friendImageNode: ASImageNode = {
        let node = ASImageNode()
        node.contentMode = .scaleAspectFit
        return node
    }()
    let friendNameLabelNode = ASTextNode()
    let friendDescLabelNode = ASTextNode()
    
    //components 속성 정의
    init(friendListModel: FriendListModel, division: KakaoFriendVC.User) {
        super.init()
        automaticallyManagesSubnodes = true
        
        switch division {
        case .myProfile:
            //friendNameLabelNode
            let attrs = [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeoSB00", size: 16.0), NSAttributedString.Key.foregroundColor: UIColor.black]
            let friendNameString = NSAttributedString(string: friendListModel.friendName, attributes: attrs as [NSAttributedString.Key : Any])
            friendNameLabelNode.attributedText = friendNameString
            
        case .friendProfile:
            //friendNameLabelNode
            let attrs = [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeoSB00", size: 12.0), NSAttributedString.Key.foregroundColor: UIColor.black]
            let friendNameString = NSAttributedString(string: friendListModel.friendName, attributes: attrs as [NSAttributedString.Key : Any])
            friendNameLabelNode.attributedText = friendNameString
        }
        
        //friendImageNode
        friendImageNode.image = UIImage(named: friendListModel.friendProfileImage)
        
        //friendDescLabelNode
        let attrs2 = [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeoR00", size: 11.0), NSAttributedString.Key.foregroundColor: UIColor.brownGrey]
        let friendDescString = NSAttributedString(string: friendListModel.friendDesc, attributes: attrs2 as [NSAttributedString.Key : Any])
        friendDescLabelNode.attributedText = friendDescString
    }
    
    // 친구프로필이미지, 친구이름, 상태메시지 LayoutSpec
    func friendListInfoLayoutSpec() -> ASLayoutSpec {
        
        specNode.styled {
            $0.height = ASDimension(unit: .points, value: 13.0)
        }
        
        let textNodeSpec = ASStackLayoutSpec(
            
            direction: .vertical,
            spacing: 1.0,
            justifyContent: .start,
            alignItems: .stretch,
            children: [
                self.specNode,
                self.friendNameLabelNode,
                self.friendDescLabelNode,
            ]
        )
        
        return ASStackLayoutSpec(
            direction: .vertical,
            spacing: 13.0,
            justifyContent: .start,
            alignItems: .stretch,
            children: [
                textNodeSpec
            ]
        )
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let friendLabelLayout = self.friendListInfoLayoutSpec()
        
        let friendImageLayout =
            ASStackLayoutSpec(
                direction: .horizontal,
                spacing: 11.0,
                justifyContent: .start,
                alignItems: .stretch,
                children: [
                    self.friendImageNode,
                    friendLabelLayout
                ]
            )
        
        return ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 0),
            child: friendImageLayout
        )
    }
}
