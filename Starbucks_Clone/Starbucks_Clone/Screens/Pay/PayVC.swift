//
//  PayVC.swift
//  Starbucks_Clone
//
//  Created by 황지은 on 2021/09/22.
//

import AsyncDisplayKit
import UIKit

class PayVC: ASDKViewController<ASDisplayNode> {
    
    var emptyPayNode = PayEmptyNode()
    
    override init() {
        super.init(node: emptyPayNode)
        self.node.backgroundColor = .white
        self.node.automaticallyManagesSubnodes = true
        self.node.automaticallyRelayoutOnSafeAreaChanges = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Layout
//    private func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
//        let contentLayout = ASStackLayoutSpec (
//            direction: .vertical,
//            spacing: 0.0,
//            justifyContent: .start,
//            alignItems: .stretch,
//            children: [
//                emptyPayNode
//            ]
//        )
//        let safeAreaInset: UIEdgeInsets = self.view.safeAreaInsets
//        return ASInsetLayoutSpec (
//            insets: safeAreaInset, child: contentLayout)
//    }
 
}
