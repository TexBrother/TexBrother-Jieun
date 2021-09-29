//
//  PayVC.swift
//  Starbucks_Clone
//
//  Created by 황지은 on 2021/09/22.
//

import AsyncDisplayKit
import Then

class PayVC: ASDKViewController<ASScrollNode> {
    
    private lazy var detailBtn = ASButtonNode().then {
        $0.setImage(UIImage(named: "hamburgerIcon"), for: .normal)
    }
    private lazy var flowLayout = UICollectionViewFlowLayout().then {
        $0.minimumInteritemSpacing = 1
    }
    private lazy var cardCV = ASCollectionNode(collectionViewLayout: flowLayout).then {
        $0.delegate = self
        $0.dataSource = self
    }
    private lazy var couponBtn = ASButtonNode()
    private lazy var egiftBtn = ASButtonNode()
    private lazy var partitionLine = ASDisplayNode().then {
        $0.backgroundColor = .lightGray
        $0.style.height = ASDimension(unit: .points, value: 10)
        $0.style.width = ASDimension(unit: .points, value: 1)
    }
    private lazy var bannerImage = ASImageNode().then {
        $0.image = UIImage(named: "banner")
    }
    
    override init() {
        super.init(node: .init())
        
        let attrs = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.black,
                     NSAttributedString.Key.kern: 0.22] as [NSAttributedString.Key : Any]
        let couponString = NSAttributedString(string: "Pay", attributes: attrs as [NSAttributedString.Key : Any])
        let egiftString = NSAttributedString(string: "e-Gift Item", attributes: attrs as [NSAttributedString.Key : Any])
        
        couponBtn.setAttributedTitle(couponString, for: .normal)
        egiftBtn.setAttributedTitle(egiftString, for: .normal)
        
        node.automaticallyManagesSubnodes = true
        node.automaticallyManagesContentSize = true
        //node.automaticallyRelayoutOnSafeAreaChanges = true
        node.layoutSpecBlock = { [weak self] (scrollNode, constraintedSize) -> ASLayoutSpec in
            return self?.layoutSpecThatFits(constraintedSize) ?? ASLayoutSpec()
        }
        node.onDidLoad({ [weak self] _ in
            self?.makeNCTitleLargeMode()
        })
        node.setNeedsLayout()
        node.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    private func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        var layoutArray = [ASLayoutElement]()
        
        if myPayCardData.count == 0 {
            layoutArray = [ cardCV, bannerImage ]
        }
        else {
            layoutArray = [ cardCV ,eventBtnStackSpec(), bannerImage ]
        }
        
        return ASStackLayoutSpec (
            direction: .vertical,
            spacing: 10.0,
            justifyContent: .center,
            alignItems: .center,
            children: layoutArray
        )
    }
    
    private func eventBtnStackSpec() -> ASStackLayoutSpec {
        
        return ASStackLayoutSpec (
            direction: .horizontal,
            spacing: 70.0,
            justifyContent: .spaceAround,
            alignItems: .stretch,
            children: [
                couponBtn,
                partitionLine,
                egiftBtn
            ]
        )
    }
    
}
extension PayVC: ASCollectionDelegate, ASCollectionDataSource, ASCollectionDelegateFlowLayout {
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        if myPayCardData.count == 0 {
            return 1
        }
        else {
            return myPayCardData.count
        }
    }
    
    func collectionView(_ collectionView: ASCollectionView, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        return {
            return PayCardCellNode(payDataModel: myPayCardData[indexPath.row])
        }
    }
}

extension PayVC {
    func makeNCTitleLargeMode() {
        navigationItem.title = "Pay"
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isHidden = false
    }
}
