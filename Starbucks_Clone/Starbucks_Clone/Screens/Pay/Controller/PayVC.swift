//
//  PayVC.swift
//  Starbucks_Clone
//
//  Created by 황지은 on 2021/09/22.

import AsyncDisplayKit
import Then
import CoreGraphics

enum payStatus {
    case empty, fill
}

class PayVC: ASDKViewController<ASScrollNode> {
    
    private lazy var detailBtn = ASButtonNode().then {
        $0.setImage(UIImage(named: "hamburgerIcon"), for: .normal)
    }
    private lazy var flowLayout = UICollectionViewFlowLayout().then {
        $0.minimumInteritemSpacing = 1
        $0.scrollDirection = .horizontal
    }
    private lazy var cardCV = ASCollectionNode(frame: .zero, collectionViewLayout: flowLayout).then {
        $0.isPagingEnabled = true
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = .systemBackground
        $0.showsHorizontalScrollIndicator = false
        $0.style.maxSize = CGSize(width: UIScreen.main.bounds.width, height: 500)
        $0.layer.cornerRadius = 15
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
        
        node.automaticallyRelayoutOnSafeAreaChanges = true
        node.automaticallyManagesSubnodes = true
        node.automaticallyManagesContentSize = true
        
        node.onDidLoad({ [weak self] _ in
            self?.makeNCTitleLargeMode()
        })
        node.backgroundColor = .white
        node.layoutSpecBlock = { node, constrainedSize in
            return self.layoutSpecThatFits(constrainedSize)
        }
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
            layoutArray = [ cardCV, eventBtnStackSpec(), bannerImage.styled {$0.spacingAfter = 0} ]
        }
        
        return ASStackLayoutSpec (
            direction: .vertical,
            spacing: 10.0,
            justifyContent: .start,
            alignItems: .center,
            children: [ cardCV,
                        eventBtnStackSpec(),
                        bannerImage.styled {
                            $0.spacingAfter = 0
                        }
                      ]
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
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let cellNodeBlock = { () -> ASCellNode in
            let cellNode =
            PayCardCellNode(payDataModel: myPayCardData[indexPath.row], division: .fill)
            return cellNode
        }
        return cellNodeBlock
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        return ASSizeRange(min: CGSize(width: 341, height: 444), max: CGSize(width: 341, height: 444))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 15)
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
//        CardDetailVC().getDataFromPayVC(cardData: myPayCardData[indexPath.row])
        
        self.navigationController?.pushViewController(CardDetailVC(cardData: myPayCardData[indexPath.row]), animated: true)
    }
}

extension PayVC {
    func makeNCTitleLargeMode() {
        navigationItem.title = "Pay"
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .gray
        navigationController?.navigationBar.isHidden = false
    }
}
