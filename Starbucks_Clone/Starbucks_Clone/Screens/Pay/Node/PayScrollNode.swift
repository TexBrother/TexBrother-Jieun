//
//  PayScrollNode.swift
//  Starbucks_Clone
//
//  Created by 황지은 on 2021/10/06.
//

import AsyncDisplayKit

class PayScrollNode: ASScrollNode {
    
    // ASScrollNode content영역 잡는 함수
    override func calculateLayoutThatFits(_ constrainedSize: ASSizeRange, restrictedTo size: ASLayoutElementSize, relativeToParentSize parentSize: CGSize) -> ASLayout {
        
        var constrainedSize = constrainedSize
        constrainedSize.min.height = 0
        constrainedSize.min.width = 0
        
        return super.calculateLayoutThatFits(constrainedSize, restrictedTo: size, relativeToParentSize: parentSize)
    }
}
