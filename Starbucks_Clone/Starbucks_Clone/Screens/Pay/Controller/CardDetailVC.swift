//
//  CardDetailVC.swift
//  Starbucks_Clone
//
//  Created by 황지은 on 2021/10/13.
//

import UIKit
import AsyncDisplayKit
import Then

class CardDetailVC: ASDKViewController<ASDisplayNode> {
    
    //MARK: - UI
    private lazy var headTextLabelNode = ASTextNode()
    private lazy var editBtnNode = ASButtonNode()
    private lazy var cardImageNode: ASImageNode = {
        let node = ASImageNode()
        node.contentMode = .scaleAspectFill
        return node
    }()
    private lazy var cardBalanceTextNode = ASTextNode()
    private lazy var balanceTextNode = ASTextNode()
    private lazy var barcodeImageNode: ASImageNode = {
        let node = ASImageNode()
        node.contentMode = .scaleAspectFit
        return node
    }()
    private lazy var cardCodeTextNode = ASTextNode()
    private lazy var validTimeTextNode = ASTextNode()
    private lazy var timerTextNode = ASTextNode()
    private lazy var settingTV = ASTableNode().then {
        $0.dataSource = self
        $0.backgroundColor = .white
    }
    
    init(cardData: PayCardData) {
        super.init(node: .init())
        self.node.backgroundColor = .white
        self.node.automaticallyManagesSubnodes = true
        self.node.automaticallyRelayoutOnSafeAreaChanges = true
        self.node.layoutSpecBlock = { [weak self] (node, constraintedSize) -> ASLayoutSpec in
            return self?.layoutSpecThatFits(constraintedSize) ?? ASLayoutSpec()
        }
        balanceTextNode.attributedText = setAttributedString(text: "카드 잔액", fontStyle: "AppleSDGothicNeoR00", fontSize: 13.0, fontColor: UIColor.black)
        validTimeTextNode.attributedText = setAttributedString(text: "바코드 유효시간", fontStyle: "AppleSDGothicNeoM00", fontSize: 12.0, fontColor: UIColor.black)
        timerTextNode.attributedText = setAttributedString(text: "60:00", fontStyle: "AppleSDGothicNeoM00", fontSize: 12.0, fontColor: UIColor.seaweedGreen)
        headTextLabelNode.attributedText = setAttributedString(text: cardData.cardName, fontStyle: "AppleSDGothicNeoB00", fontSize: 30.0, fontColor: UIColor.black)
        cardImageNode.image = UIImage(named: cardData.cardImage)
        cardBalanceTextNode.attributedText = setAttributedString(text: cardData.balance, fontStyle: "AppleSDGothicNeoB00", fontSize: 20.0, fontColor: UIColor.black)
        barcodeImageNode.image = UIImage(named: cardData.cardBarcodeImage)
        cardCodeTextNode.attributedText = setAttributedString(text: cardData.cardCode, fontStyle: "AppleSDGothicNeoM00", fontSize: 15.0, fontColor: UIColor.black)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardImageNode.layer.cornerRadius = 10.0
        settingTV.view.allowsSelection = true
        settingTV.view.separatorStyle = .none
        settingTV.view.backgroundColor = .systemGray6
        settingTV.view.showsVerticalScrollIndicator = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // Attribute String 설정
    func setAttributedString(text: String, fontStyle: String, fontSize: CGFloat, fontColor: UIColor) -> NSAttributedString {
        let attrs = [NSAttributedString.Key.font: UIFont(name: fontStyle, size: fontSize), NSAttributedString.Key.foregroundColor: fontColor]
        let attrString = NSAttributedString(string: text, attributes: attrs as [NSAttributedString.Key : Any])
        
        return attrString
    }
    
    func topCardLayoutSpec() -> ASLayoutSpec {
        
        let headTextEditBtnSepc = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 0.0,
            justifyContent: .start,
            alignItems: .start,
            children: [
                headTextLabelNode
            ]
        )
        
        let balanceSpec = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 3.0,
            justifyContent: .spaceBetween,
            alignItems: .start,
            children: [
                balanceTextNode,
                cardBalanceTextNode
            ]
        )
        
        cardImageNode.styled {
            $0.width = ASDimension(unit: .points, value: 110)
            $0.height = ASDimension(unit: .points, value: 80)
        }
        
        let cardImageBalanceSpec = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 10.0,
            justifyContent: .start,
            alignItems: .start,
            children: [
                cardImageNode,
                balanceSpec
            ]
        )
        
        let cardAreaSpec = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 35.0,
            justifyContent: .start,
            alignItems: .start,
            children: [
                headTextEditBtnSepc,
                cardImageBalanceSpec
            ]
        )
        
        return ASInsetLayoutSpec(
            insets: UIEdgeInsets(),
            child: cardAreaSpec
        )
    }
    
    func topBarCodeLayoutSpec() -> ASLayoutSpec {
        
        let barcodeSpec = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 10,
            justifyContent: .spaceBetween,
            alignItems: .center,
            children: [
                barcodeImageNode,
                cardCodeTextNode
            ]
        )
        
        let timerSpec = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 5.0,
            justifyContent: .center,
            alignItems: .center,
            children: [
                validTimeTextNode,
                timerTextNode
            ]
        )
        
        let specNode = ASDisplayNode()
        specNode.styled {
            $0.height = ASDimension(unit: .points, value: 10.0)
        }
        
        let barcodeAreaSpec = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 10.0,
            justifyContent: .center,
            alignItems: .center,
            children: [
                barcodeSpec,
                timerSpec,
                specNode
                
            ]
        )
        
        return ASInsetLayoutSpec(
            insets: UIEdgeInsets(),
            child: barcodeAreaSpec
        )
    }

    
    func topLayoutSpec() -> ASLayoutSpec {
        
        let contentLayout = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 30.0,
            justifyContent: .start,
            alignItems: .stretch,
            children: [
                topCardLayoutSpec(),
                topBarCodeLayoutSpec()
            ]
        )
        
        return ASInsetLayoutSpec (
            insets: UIEdgeInsets(top: 100, left: 20, bottom: 0, right: 40),
            child: contentLayout
        )
    }
    
    private func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        
        let contentLayout = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 10.0,
            justifyContent: .start,
            alignItems: .stretch,
            children: [
                topLayoutSpec(),
                settingTV.styled {
                    $0.flexGrow = 1.0
                }
            ]
        )
        
        return ASInsetLayoutSpec (
            insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
            child: contentLayout
        )
    }
}

//MARK: - TableDelegate, TableDataSource
extension CardDetailVC: ASTableDelegate, ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        settingTV.delegate = self
        return SettingTVCellNode(settingModel: settingData[indexPath.row])
    }
    
    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        return ASSizeRange(min: CGSize(width: 375, height: 60), max: CGSize(width: 375, height: 60))
    }
    
    //tableViewCell의 레이어 변경
    func tableNode(_ tableNode: ASTableNode, willDisplayRowWith node: ASCellNode) {
        node.backgroundColor = .systemGray6
    }
}
