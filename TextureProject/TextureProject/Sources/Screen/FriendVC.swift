//
//  FriendVC.swift
//  TextureProject
//
//  Created by 황지은 on 2021/09/01.
//

import UIKit
import AsyncDisplayKit

class FriendVC: ASDKViewController<ASDisplayNode> {
    
    override init() {
        super.init(node: ASDisplayNode())
    }
    var profileNode: ProfileDisplayNode = ProfileDisplayNode(profileImage: "", nickname: "", division: .friendProfile)
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: Initializing
    init(_ profileImage: String, _ nickname: String, _ division: KakaoFriendVC.User) {
        super.init(node: .init())
        self.node.backgroundColor = .coolGrey
        
        profileNode = ProfileDisplayNode(profileImage: profileImage, nickname: nickname, division: division)
        
        self.node.automaticallyManagesSubnodes = true
        self.node.automaticallyRelayoutOnSafeAreaChanges = true

        self.node.layoutSpecBlock = { [weak self] (node, constraintedSize) -> ASLayoutSpec in
            return self?.layoutSpecThatFits(constraintedSize) ?? ASLayoutSpec()
        }
        self.node.onDidLoad({ [weak self] _ in
//            self?.dismissBtn.addTarget(self, action: #selector(self?.dismissAction), forControlEvents: .touchUpInside)
//            self?.chatBtn.addTarget(self, action: #selector(self?.chatBtnAction), forControlEvents: .touchUpInside)
//            self?.editBtn.addTarget(self, action: #selector(self?.editBtnAction), forControlEvents: .touchUpInside)
//            self?.storyBtn.addTarget(self, action: #selector(self?.storyBtnAction), forControlEvents: .touchUpInside)
        })
    }
    // MARK: Layout
    private func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        let contentLayout = ASStackLayoutSpec (
            direction: .vertical,
            spacing: 0.0,
            justifyContent: .start,
            alignItems: .stretch,
            children: [
                profileNode
            ]
        )
        let safeAreaInset: UIEdgeInsets = self.view.safeAreaInsets
        return ASInsetLayoutSpec (
            insets: safeAreaInset, child: profileNode
        )
    }
}
