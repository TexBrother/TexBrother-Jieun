//
//  ApplistCellNode.swift
//  TextureProject
//
//  Created by 황지은 on 2021/08/18.
//

import AsyncDisplayKit

class ApplistCellNode: ASCellNode {
    
    let specNode = ASDisplayNode()
    
    let appIconImageNode: ASImageNode = {
        let node = ASImageNode()
        node.contentMode = .scaleAspectFit
        return node
    }()
    let appNameLabelNode = ASTextNode()
    let appDescLabelNode = ASTextNode()
    let installButtonNode = ASButtonNode()
    let lineDisplayNode = ASDisplayNode()
    
    
    init(applistModel: ApplistModel) {
        super.init()
        automaticallyManagesSubnodes = true
        
        //appIconImageNode
        appIconImageNode.image = UIImage(named: applistModel.appIconImage)
        
        //appNameLabelNode
        let attrs = [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeoM00", size: 13.0), NSAttributedString.Key.foregroundColor: UIColor.white]
        let appNameString = NSAttributedString(string: applistModel.appName, attributes: attrs as [NSAttributedString.Key : Any])
        appNameLabelNode.attributedText = appNameString
        
        //appDescLabelNode
        let attrs2 = [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeoR00", size: 11.0), NSAttributedString.Key.foregroundColor: UIColor.white]
        let appDescString = NSAttributedString(string: applistModel.appDesc, attributes: attrs2 as [NSAttributedString.Key : Any])
        appDescLabelNode.attributedText = appDescString
        
        //installButtonNode
        installButtonNode.layer.cornerRadius = 13
        installButtonNode.backgroundColor = .buttonGrey
        installButtonNode.setTitle("받기", with: .AppleSDGothicB(size: 12), with: .coralBlue, for: .normal)
        
        //lineDisplayNode
        lineDisplayNode.layer.backgroundColor = UIColor.lineGrey.cgColor
    }
    
    // 앱이름, 앱설명, 버튼, 선 LayoutSpec
    func appListInfoLayoutSpec() -> ASLayoutSpec {
        
        specNode.styled {
            $0.height = ASDimension(unit: .points, value: 13.0)
        }
        
        let textNodeSpec = ASStackLayoutSpec(
            
            direction: .vertical,
            spacing: 6.0,
            justifyContent: .start,
            alignItems: .stretch,
            children: [
                self.specNode,
                self.appNameLabelNode,
                self.appDescLabelNode,
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
        
        let infoLayout = self.appListInfoLayoutSpec()
        
        let appImageLayout =
            ASStackLayoutSpec(
                direction: .horizontal,
                spacing: 20.0,
                justifyContent: .start,
                alignItems: .stretch,
                children: [
                    self.appIconImageNode,
                    infoLayout
                ]
            )
        
        return ASInsetLayoutSpec(
            insets: UIEdgeInsets(),
            child: appImageLayout
        )
    }
}
