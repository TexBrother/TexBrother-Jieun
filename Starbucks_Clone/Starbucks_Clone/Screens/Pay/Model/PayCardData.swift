//
//  PayCardData.swift
//  Starbucks_Clone
//
//  Created by 황지은 on 2021/09/29.
//

import Foundation

struct PayCardData {
    var cardImage: String
    var cardName: String
    var cardFavoriteState: Bool
    var balance: String
    var cardBarcodeImage: String
    var cardCode: String
}

var myPayCardData: [PayCardData] = [
    PayCardData(cardImage: "card1", cardName: "Thank You 카드", cardFavoriteState: true, balance: "2,300원", cardBarcodeImage: "barcode", cardCode: "****_****_**36-6582"),
    PayCardData(cardImage: "card2", cardName: "2018 Limited Edition", cardFavoriteState: false, balance: "3,400원", cardBarcodeImage: "barcode", cardCode: "****_****_**36-6582")
]
