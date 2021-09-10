//
//  KakaoFriendVC.swift
//  TextureProject
//
//  Created by 황지은 on 2021/09/01.
//

import AsyncDisplayKit

class KakaoFriendVC: ASDKViewController<ASDisplayNode> {
    
    enum User: Int, CaseIterable {
        case myProfile
        case friendProfile
    }
    
    // MARK: UI
    private lazy var tableNode: ASTableNode = {
        let node = ASTableNode(style: .plain)
        node.delegate = self
        node.dataSource = self
        node.backgroundColor = .white
        node.allowsSelection = false
        node.view.separatorStyle = .none
        return node
    }()
    
    var headerNode = KakaoFriendHeaderNode()
    
    // MARK: Initializing
    override init() {
        super.init(node: .init())
        self.node.backgroundColor = .white
        self.node.automaticallyManagesSubnodes = true
        self.node.automaticallyRelayoutOnSafeAreaChanges = true
        self.node.layoutSpecBlock = { [weak self] (node, constraintedSize) -> ASLayoutSpec in
            return self?.layoutSpecThatFits(constraintedSize) ?? ASLayoutSpec()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  makeFriendlists()
    }
    
    // MARK: Layout
    private func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        let contentLayout = ASStackLayoutSpec (
            direction: .vertical,
            spacing: 0.0,
            justifyContent: .start,
            alignItems: .stretch,
            children: [
                headerNode,
                tableNode.styled({
                    $0.flexGrow = 1.0
                })
            ]
        )
        let safeAreaInset: UIEdgeInsets = self.view.safeAreaInsets
        return ASInsetLayoutSpec (
            insets: safeAreaInset, child: contentLayout)
    }
}

extension KakaoFriendVC: ASTableDelegate, ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 2
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        else {
            return friendList.count - 1
        }
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        if indexPath.section == 0 {
            return KakaoFriendCellNode(friendListModel: friendList[0], division: .myProfile)
        }
        else {
            return KakaoFriendCellNode(friendListModel: friendList[indexPath.row + 1], division: .friendProfile)
        }
    }
    
    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        if indexPath.section == 0 {
            return ASSizeRange(min: CGSize(width: 375, height: 73), max: CGSize(width: 375, height: 73))
        }
        else {
            return ASSizeRange(min: CGSize(width: 375, height: 50), max: CGSize(width: 375, height: 50))
        }
    }
    
    //tableView의 레이어 변경
    func tableNode(_ tableNode: ASTableNode, willDisplayRowWith node: ASCellNode) {
        node.backgroundColor = .white
    }
}
