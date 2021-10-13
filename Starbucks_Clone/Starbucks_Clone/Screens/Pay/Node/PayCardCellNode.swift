//
//  PayCardCellNode.swift
//  Starbucks_Clone
//
//  Created by 황지은 on 2021/09/29.
//

import AsyncDisplayKit

class PayCardCellNode: ASCellNode {
    
    let specNode = ASDisplayNode()
    
    let cardImageNode: ASImageNode = {
        let node = ASImageNode()
        node.contentMode = .scaleAspectFit
        return node
    }()
    let cardNameLabelNode = ASTextNode()
    let balanceLabelNode = ASTextNode()
    let installButtonNode = ASButtonNode()
    let lineDisplayNode = ASDisplayNode()

    init(payDataModel: PayCardData, division: payStatus) {
        super.init()
        automaticallyManagesSubnodes = true
        
        switch division {
        case .empty:
            print("empty")
        case .fill:
            print("fill")
        }
        self.backgroundColor = .black
        cardImageNode.image = UIImage(named: payDataModel.cardImage)
    }
    
    func payCellLayoutSpec() -> ASLayoutSpec {
        
        specNode.styled {
            $0.height = ASDimension(unit: .points, value: 19.0)
        }
        
        let textNodeSpec = ASStackLayoutSpec(
            
            direction: .vertical,
            spacing: 6.0,
            justifyContent: .start,
            alignItems: .stretch,
            children: [
                self.specNode
            ]
        )
        
        let textAndButtonSpec = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 16.0,
            justifyContent: .start,
            alignItems: .stretch,
            children: [
                textNodeSpec,
                self.installButtonNode,
            ]
        )
        
        self.installButtonNode.styled {
            $0.height = ASDimension(unit: .points, value: 25)
            $0.width = ASDimension(unit: .points, value: 65)
        }
        
        return ASStackLayoutSpec(
            direction: .vertical,
            spacing: 13.0,
            justifyContent: .start,
            alignItems: .stretch,
            children: [
                textAndButtonSpec,
                self.lineDisplayNode,
            ]
        )
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let infoLayout = self.payCellLayoutSpec()
        
        let payCellLayout =
            ASStackLayoutSpec(
                direction: .horizontal,
                spacing: 20.0,
                justifyContent: .start,
                alignItems: .stretch,
                children: [
                    infoLayout
                ]
            )
        
        return ASInsetLayoutSpec(
            
            insets: UIEdgeInsets(),
            child: payCellLayout
        )
    }
}
