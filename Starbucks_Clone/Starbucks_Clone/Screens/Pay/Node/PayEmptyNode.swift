//
//  PayEmptyNode.swift
//  Starbucks_Clone
//
//  Created by 황지은 on 2021/09/22.
//

import UIKit
import AsyncDisplayKit

class PayEmptyNode: ASDisplayNode {
    
    let specNode = ASDisplayNode()
    let widthSpecNode = ASDisplayNode()
    
    let headTextNode: ASTextNode = {
        let node = ASTextNode()
        return node
    }()
    
    let whiteView : ASDisplayNode = {
        let node = ASDisplayNode()
        node.style.width = ASDimension(unit: .points, value: 355)
        node.style.height = ASDimension(unit: .points, value: 444)
        node.backgroundColor = .white
        node.cornerRadius = 10
        node.layer.shadowOpacity = 0.2
        node.layer.shadowOffset = CGSize(width: 3, height: 3)
        node.layer.shadowRadius = 10
        node.layer.masksToBounds = false
        return node
    }()
    
    let emptyCardButtonNode : ASButtonNode = {
        let node = ASButtonNode()
        node.style.width = ASDimension(unit: .points, value: 297)
        node.style.height = ASDimension(unit: .points, value: 189)
        node.setImage(UIImage(named: "emptyPayCardView"), for: .normal)
        return node
    }()
    
    let emptyTitleTextNode = ASTextNode()
    let emptySubTextNode = ASTextNode()
    
    let bannerImageNode : ASImageNode = {
        let node = ASImageNode()
        node.image = UIImage(named: "banner")
        node.style.width = ASDimension(unit: .points, value: UIScreen.main.bounds.size.width)
        return node
    }()
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        
        let headAttrs = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 28), NSAttributedString.Key.foregroundColor: UIColor.black,
                         NSAttributedString.Key.kern: 1.12] as [NSAttributedString.Key : Any]
        let headString = NSAttributedString(string: "Pay", attributes: headAttrs as [NSAttributedString.Key : Any])
        
        headTextNode.attributedText = headString
        
        let emptyTitleAttrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .semibold), NSAttributedString.Key.foregroundColor: UIColor.black,
                               NSAttributedString.Key.kern: 0.17] as [NSAttributedString.Key : Any]
        let emptyTitleString = NSAttributedString(string: "스타벅스 카드를 등록해보세요.", attributes: emptyTitleAttrs as [NSAttributedString.Key : Any])
        
        emptyTitleTextNode.attributedText = emptyTitleString
        
        let emptySubAttrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .medium), NSAttributedString.Key.foregroundColor: UIColor.brownGrey,
                             NSAttributedString.Key.kern: 0.2] as [NSAttributedString.Key : Any]
        let emptySubString = NSAttributedString(string: "매장과 사이렌오더에서 쉽고 편리하게 \n사용할 수 있고, 별도 적립할 수 있습니다.", attributes: emptySubAttrs as [NSAttributedString.Key : Any])
        
        emptySubTextNode.attributedText = emptySubString
    }
    
    // MARK: Node Life Cycle
    override func layout() {
        super.layout()
    }
    
    // MARK: Layout
    
    func emptyPayViewLayoutSpec() -> ASLayoutSpec {
        
        specNode.styled {
            $0.height = ASDimension(unit: .points, value: 98.0)
        }
        
        widthSpecNode.styled {
            $0.width = ASDimension(unit: .points, value: 17.0)
        }
        
        let nodeSpec = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 0,
            justifyContent: .start,
            alignItems: .start,
            children: [
                specNode,
                headTextNode,
            ]
        )
        
        let whiteBackViewNodeSpec = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 22.0,
            justifyContent: .center,
            alignItems: .stretch,
            children: [
                nodeSpec,
                self.whiteView
            ]
        )
        //
        //        let emptyPayViewNodeSpec = ASStackLayoutSpec(
        //            direction: .vertical,
        //            spacing: 19.0,
        //            justifyContent: .start,
        //            alignItems: .stretch,
        //            children: [
        //                //whiteBackViewNodeSpec,
        //                self.emptyCardButtonNode
        //            ]
        //        )
        //
        //        let betweenEmptyCardTitleTextNodeSpec = ASStackLayoutSpec(
        //            direction: .vertical,
        //            spacing: 28.0,
        //            justifyContent: .start,
        //            alignItems: .stretch,
        //            children: [
        //                emptyPayViewNodeSpec,
        //                self.emptyTitleTextNode
        //            ]
        //        )
        //
        //        let betweenTitleSubTextNodeSpec = ASStackLayoutSpec(
        //            direction: .vertical,
        //            spacing: 11.0,
        //            justifyContent: .start,
        //            alignItems: .stretch,
        //            children: [
        //                betweenEmptyCardTitleTextNodeSpec,
        //                self.emptySubTextNode
        //            ]
        //        )
        //
        
        return ASStackLayoutSpec(
            direction: .vertical,
            spacing: 0.0,
            justifyContent: .start,
            alignItems: .stretch,
            children: [
                whiteBackViewNodeSpec
            ]
        )
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let cardLayout = self.emptyPayViewLayoutSpec()
        
        let widthNodeSpec = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 0,
            justifyContent: .start,
            alignItems: .start,
            children: [
            widthSpecNode,
            cardLayout
        ])
        
        let bannerNodeSpec = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 26.0,
            justifyContent: .start,
            alignItems: .start,
            children: [
                widthNodeSpec,
                self.bannerImageNode
            ]
        )
        
        return ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
            child: bannerNodeSpec
        )
    }
}
