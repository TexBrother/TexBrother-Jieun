//
//  PaySettingData.swift
//  Starbucks_Clone
//
//  Created by 황지은 on 2021/10/13.
//

import Foundation
struct PaySettingData {
    var icon: String
    var settingName: String
}

var settingData: [PaySettingData] = [
    PaySettingData(icon: "autoChargeIcon", settingName: "이용 내역"),
    PaySettingData(icon: "autoChargeIcon", settingName: "자동 충전"),
    PaySettingData(icon: "generalChargeIcon", settingName: "일반 충전"),
    PaySettingData(icon: "generalChargeIcon", settingName: "분실 신고 및 잔액 이전"),
    PaySettingData(icon: "autoChargeIcon", settingName: "카드 등록 해지")
]
