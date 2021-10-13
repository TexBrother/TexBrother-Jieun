//
//  PayCardCellNode.swift
//  Starbucks_Clone
//
//  Created by 황지은 on 2021/09/29.
//

import AsyncDisplayKit
import Darwin

class PayCardCellNode: ASCellNode {
    
    let specNode = ASDisplayNode()
    let cardImageNode: ASImageNode = {
        let node = ASImageNode()
        node.contentMode = .scaleAspectFit
        return node
    }()
    let cardNameLabelNode = ASTextNode()
    let favoriteBtnNode = ASButtonNode()
    let balanceLabelNode = ASTextNode()
    let barcodeImageNode: ASImageNode = {
        let node = ASImageNode()
        node.contentMode = .scaleAspectFit
        return node
    }()
    let cardCodeLabelNode = ASTextNode()
    let validLabelNode = ASTextNode()
    let timerLabelNode = ASTextNode()
    private var backview: ASDisplayNode = {
        let node = ASDisplayNode()
        node.backgroundColor = .white
        node.cornerRadius = 15
        node.shadowOffset = CGSize(width: 2, height: 2)
        node.shadowColor = UIColor.gray.cgColor
        node.shadowRadius = 7
        node.shadowOpacity = 0.4
        return node
    }()
    
    init(payDataModel: PayCardData, division: payStatus) {
        super.init()
        automaticallyManagesSubnodes = true
        self.backgroundColor = .white
        
        switch division {
        case .empty:
            print("empty")
        case .fill:
            print("fill")
        }
        cardImageNode.image = UIImage(named: payDataModel.cardImage)
        cardNameLabelNode.attributedText = setAttributedString(text: payDataModel.cardName, fontStyle: "AppleSDGothicNeoSB00", fontSize: 13.0, fontColor: UIColor.black)
        
        if payDataModel.cardFavoriteState {
            favoriteBtnNode.setImage(UIImage(named: "favoriteIcon"), for: .normal)
        }
        else {
            favoriteBtnNode.setImage(UIImage(named: "notFavoriteIcon"), for: .normal)
        }
        
        balanceLabelNode.attributedText = setAttributedString(text: payDataModel.balance, fontStyle: "AppleSDGothicNeoB00", fontSize: 23.0, fontColor: UIColor.black)
        barcodeImageNode.image = UIImage(named: payDataModel.cardBarcodeImage)
        cardCodeLabelNode.attributedText = setAttributedString(text: payDataModel.cardCode, fontStyle: "AppleSDGothicNeoM00", fontSize: 15.0, fontColor: UIColor.black)
        validLabelNode.attributedText = setAttributedString(text: "바코드 유효시간", fontStyle: "AppleSDGothicNeoM00", fontSize: 12.0, fontColor: UIColor.black)
    }
    
    // Attribute String 설정
    func setAttributedString(text: String, fontStyle: String, fontSize: CGFloat, fontColor: UIColor) -> NSAttributedString {
        let attrs = [NSAttributedString.Key.font: UIFont(name: fontStyle, size: fontSize), NSAttributedString.Key.foregroundColor: fontColor]
        let attrString = NSAttributedString(string: text, attributes: attrs as [NSAttributedString.Key : Any])
        
        return attrString
    }
    
    // 카드이름 <-> 좋아요버튼 Stack Spec
    func cardNameStarBtnStackSpec() -> ASLayoutSpec {
        
        favoriteBtnNode.styled {
            $0.width = ASDimension(unit: .points, value: 21.0)
            $0.height = ASDimension(unit: .points, value: 21.0)
        }
        
        return ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 7.0,
            justifyContent: .spaceBetween,
            alignItems: .start,
            children: [
                cardNameLabelNode,
                favoriteBtnNode
            ]
        )
    }
    
    //바코드 유효시간 Label <-> Timer Spec
    func barcodeValidTimerSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 3.0,
            justifyContent: .spaceBetween,
            alignItems: .start,
            children: [
                validLabelNode,
                timerLabelNode
            ]
        )
    }
    
    //    // 자동 충전 이비지 + 버튼
    //    func autoChargeStackSpec() -> ASLayoutSpec {
    //
    //    }
    //
    //    // 일반 충전 이비지 + 버튼
    //    func generalChargeStackSpec() -> ASLayoutSpec {
    //
    //    }
    
    //최종 layoutSpec
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return overlayLayoutSpec()
        
    }
    
    func overallLayoutSpec() -> ASLayoutSpec {
        
        let cardNameStarBtn = self.cardNameStarBtnStackSpec()
        let validBarcodeTimer = self.barcodeValidTimerSpec()
        
        let cardImgNameLayout =
        ASStackLayoutSpec(
            direction: .vertical,
            spacing: 26.0,
            justifyContent: .center,
            alignItems: .center,
            children: [
                cardImageNode,
                cardNameStarBtn
            ]
        )
        let balanceLayout = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 0,
            justifyContent: .center,
            alignItems: .center,
            children: [
                cardImgNameLayout,
                balanceLabelNode
            ]
        )
        
        barcodeImageNode.styled {
            $0.width = ASDimension(unit: .points, value: 197.0)
            $0.height = ASDimension(unit: .points, value: 38.0)
        }
        
        let barcodeLayout = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 13.0,
            justifyContent: .center,
            alignItems: .center,
            children: [
                balanceLayout,
                barcodeImageNode
            ]
        )
        
        let cardCodeLayout = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 6.0,
            justifyContent: .center,
            alignItems: .center,
            children: [
                barcodeLayout,
                cardCodeLabelNode
            ]
        )
        
        let validLabelLayout = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 8.0,
            justifyContent: .center,
            alignItems: .center,
            children: [
                cardCodeLayout,
                validBarcodeTimer
            ]
        )
        
        return ASInsetLayoutSpec(
            
            insets: UIEdgeInsets(top: 0, left: 19, bottom: 0, right: 19),
            child: validLabelLayout
        )
    }
    
    private func overlayLayoutSpec() -> ASLayoutSpec {
        return ASOverlayLayoutSpec(child: backview, overlay: overallLayoutSpec())
    }
}
