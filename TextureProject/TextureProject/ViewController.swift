//
//  ViewController.swift
//  TextureProject
//
//  Created by 황지은 on 2021/08/18.
//

import AsyncDisplayKit

class ViewController: ASDKViewController<ASTableNode> {
    var applist: [ApplistModel] = []
    
    override init() {
        super.init(node: ASTableNode())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        makeApplists()
        self.node.view.allowsSelection = false
        self.node.view.separatorStyle = .none
        self.node.view.backgroundColor = .black
        self.node.delegate = self
        self.node.dataSource = self
    }
    
    func makeApplists() {
        applist = [
           // ApplistModel(appIconImage: "cherishAppIcon", appName: "Cherish - 연락을 이어가는 가장 쉬운 방법", appDesc: "연락이 점점 일처럼 느껴지지 않나요? \n Cherish에서 식물을 키우며 연락을 보다 재미있게 즐겨봐요!"),
           // ApplistModel(appIconImage: "charoAppIcon", appName: "Charo - 드라이브코스 공유 서비스", appDesc: "차에서의, 차로위에서의 즐거움을 추구하는 경험 기반 드라이브 코스 공유 플랫폼"),
            ApplistModel(appIconImage: "soptAppIcon1", appName: "OUNCE - 집사를 위한 똑똑한 기록장", appDesc: "우리 고양이의 까다로운 입맛 정리 서비스"),
            ApplistModel(appIconImage: "soptAppIcon2", appName: "포켓유니브", appDesc: "MZ세대를 위한, 올인원 대학생활 관리 플랫폼"),
            ApplistModel(appIconImage: "soptAppIcon3", appName: "MOMO", appDesc: "책 속의 문장과 함께 쓰는 일기"),
            ApplistModel(appIconImage: "soptAppIcon4", appName: "Weathy(웨디)", appDesc: "나를 알아가는 질문 다이어리"),
            ApplistModel(appIconImage: "soptAppIcon5", appName: "BeMe", appDesc: "우리들끼리 공유하는 최애장소, 플레이스픽"),
            ApplistModel(appIconImage: "soptAppIcon6", appName: "placepic", appDesc: "나에게 돌아오는 맞춤 날씨 서비스"),
            ApplistModel(appIconImage: "soptAppIcon7", appName: "몽글(Mongle)", appDesc: "우리가 만드는 문장 큐레이션 플랫폼, 몽글"),
            ApplistModel(appIconImage: "soptAppIcon1", appName: "OUNCE - 집사를 위한 똑똑한 기록장", appDesc: "우리 고양이의 까다로운 입맛 정리 서비스")
        ]
    }
}

extension ViewController: ASTableDelegate, ASTableDataSource {
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return applist.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        return ApplistCellNode(applistModel: applist[indexPath.row])
    }
    
    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        return ASSizeRange(min: CGSize(width: 375, height: 106), max: CGSize(width: 375, height: 106))
    }
    
    //tableView의 레이어 변경
    func tableNode(_ tableNode: ASTableNode, willDisplayRowWith node: ASCellNode) {
        node.backgroundColor = .black
    }
}
