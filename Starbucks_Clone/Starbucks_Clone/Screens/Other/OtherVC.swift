//
//  OtherVC.swift
//  Starbucks_Clone
//
//  Created by 황지은 on 2021/09/22.
//

import AsyncDisplayKit

class OtherVC: ASDKViewController<ASDisplayNode> {
    
    override init() {
        super.init(node: ASDisplayNode())
        node.backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
