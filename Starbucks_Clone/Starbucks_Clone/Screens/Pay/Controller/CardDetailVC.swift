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
    private lazy var cardImageNode = ASImageNode()
    private lazy var cardBalanceTextNode = ASTextNode()
    private lazy var balanceTextNode = ASTextNode()
    private lazy var barcodeImageNode = ASImageNode()
    private lazy var cardCodeTextNode = ASTextNode()
    private lazy var validTimeTextNode = ASTextNode()
    private lazy var timerTextNode = ASTextNode()
    private lazy var settingTV = ASTableNode().then {
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = .white
        $0.view.allowsSelection = true
        $0.view.separatorStyle = .singleLine
        $0.view.backgroundColor = .systemGray
    }
    
    var cardName: String?
    var cardImage: String?
    var cardBalance: String?
    var barcodeImage: String?
    var cardCode: String?
    
    func getDataFromPayVC() {
        print("hello?")
        if let name = cardName {
            headTextLabelNode.attributedText = setAttributedString(text: name, fontStyle: "AppleSDGothicNeoB00", fontSize: 30.0, fontColor: UIColor.black)
        }
        if let cardImg = cardImage {
            cardImageNode.image = UIImage(named: cardImg)
        }
        if let balance = cardBalance {
            cardBalanceTextNode.attributedText = setAttributedString(text: balance, fontStyle: "AppleSDGothicNeoSB00", fontSize: 18.0, fontColor: UIColor.black)
        }
        if let barcode = barcodeImage {
            barcodeImageNode.image = UIImage(named: barcode)
        }
        if let code = cardCode {
            cardCodeTextNode.attributedText = setAttributedString(text: code, fontStyle: "AppleSDGothicNeoM00", fontSize: 15.0, fontColor: UIColor.black)
        }
    }
    
    override init() {
        super.init(node: .init())
        self.node.backgroundColor = .white
        getDataFromPayVC()
        validTimeTextNode.attributedText = setAttributedString(text: "바코드 유효시간", fontStyle: "AppleSDGothicNeoM00", fontSize: 12.0, fontColor: UIColor.black)
        timerTextNode.attributedText = setAttributedString(text: "60:00", fontStyle: "AppleSDGothicNeoM00", fontSize: 12.0, fontColor: UIColor.seaweedGreen)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Attribute String 설정
    func setAttributedString(text: String, fontStyle: String, fontSize: CGFloat, fontColor: UIColor) -> NSAttributedString {
        let attrs = [NSAttributedString.Key.font: UIFont(name: fontStyle, size: fontSize), NSAttributedString.Key.foregroundColor: fontColor]
        let attrString = NSAttributedString(string: text, attributes: attrs as [NSAttributedString.Key : Any])
        
        return attrString
    }
    
    func topLayoutSpec() -> ASLayoutSpec {
        
        let headTextEditBtnSepc = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 30,
            justifyContent: .spaceBetween,
            alignItems: .start,
            children: [
                headTextLabelNode,
                editBtnNode
            ]
        )
        
        let balanceSpec = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 10.0,
            justifyContent: .spaceBetween,
            alignItems: .start,
            children: [
                balanceTextNode,
                cardBalanceTextNode
            ])
        
        cardImageNode.styled {
            $0.width = ASDimension(unit: .points, value: 50)
            $0.height = ASDimension(unit: .points, value: 30)
        }
        
        let cardImageBalanceSpec = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 10.0,
            justifyContent: .spaceBetween,
            alignItems: .start,
            children: [
                cardImageNode,
                balanceSpec
            ])
        
        let barcodeSpec = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 10,
            justifyContent: .spaceBetween,
            alignItems: .center,
            children: [
                barcodeImageNode,
                cardCodeTextNode
            ])
        
        let finLayoutSpec = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 20.0,
            justifyContent: .spaceBetween,
            alignItems: .start,
            children: [
                headTextEditBtnSepc,
                cardImageBalanceSpec,
                barcodeSpec
            ]
        )
        
        return ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 5, left: 16, bottom: 0, right: 16),
            child: finLayoutSpec)
    }
    
    private func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        
        let contentLayout = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 0.0,
            justifyContent: .start,
            alignItems: .center,
            children: [
            topLayoutSpec(),
            settingTV
            ]
        )
        
        let safeAreaInset: UIEdgeInsets = self.view.safeAreaInsets
        return ASInsetLayoutSpec (
            insets: safeAreaInset, child: contentLayout
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
        return SettingTVCellNode(settingModel: settingData[indexPath.row])
    }
    
    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        return ASSizeRange(min: CGSize(width: 375, height: 300), max: CGSize(width: 375, height: 300))
    }
    
    //tableView의 레이어 변경
    func tableNode(_ tableNode: ASTableNode, willDisplayRowWith node: ASCellNode) {
        node.backgroundColor = .systemGray
    }
}
