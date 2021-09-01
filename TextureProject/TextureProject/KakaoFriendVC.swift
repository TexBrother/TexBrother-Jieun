//
//  KakaoFriendVC.swift
//  TextureProject
//
//  Created by 황지은 on 2021/09/01.
//

import AsyncDisplayKit

class KakaoFriendVC: ASDKViewController<ASTableNode> {

    var friendList: [FriendListModel] = []
    
    override init() {
        super.init(node: ASTableNode())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeFriendlists()
        self.node.view.allowsSelection = false
        self.node.view.separatorStyle = .none
        self.node.view.backgroundColor = .white
        self.node.delegate = self
        self.node.dataSource = self
    }
    
    func makeFriendlists() {
        friendList = [
            FriendListModel(friendProfileImage: "friendtabProfileImg", friendName: "김솝트", friendDesc: "상태메시지는 여기에"),
            FriendListModel(friendProfileImage: "profileImage1", friendName: "안솝트", friendDesc: "배고파요"),
            FriendListModel(friendProfileImage: "profileImage2", friendName: "최솝트", friendDesc: "피곤해요"),
            FriendListModel(friendProfileImage: "profileImage3", friendName: "정솝트", friendDesc: "살려줘요"),
            FriendListModel(friendProfileImage: "profileImage4", friendName: "이솝트", friendDesc: "워우워~~"),
            FriendListModel(friendProfileImage: "profileImage5", friendName: "유솝트", friendDesc: "나는 상태메시지!"),
            FriendListModel(friendProfileImage: "profileImage6", friendName: "박솝트", friendDesc: "배고파요"),
            FriendListModel(friendProfileImage: "profileImage7", friendName: "박솝트", friendDesc: "배고파요"),
            FriendListModel(friendProfileImage: "profileImage8", friendName: "박솝트", friendDesc: "배고파요"),
            FriendListModel(friendProfileImage: "profileImage9", friendName: "박솝트", friendDesc: "배고파요"),
            FriendListModel(friendProfileImage: "profileImage10", friendName: "박솝트", friendDesc: "배고파요"),
        ]
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
            return KakaoFriendCellNode(friendListModel: friendList[0])
        }
        else {
            return KakaoFriendCellNode(friendListModel: friendList[indexPath.row + 1])
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
