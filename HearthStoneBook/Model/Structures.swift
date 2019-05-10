//
//  Structures.swift
//  HearthStoneBook
//
//  Created by Даниил on 09/05/2019.
//  Copyright © 2019 Даниил. All rights reserved.
//

import Foundation

//Структура карты
struct hsCard: Codable {
    var cardId: String?
    var dbfId: String?
    var name: String?
    var cardSet: String?
    var type: String?
    var faction: String?
    var rarity: String?
    var cost: Int?
    var attack: Int?
    var health: Int?
    var text: String?
    var flavor: String?
    var artist: String?
    var collectible: Bool?
    var elite: Bool?
    var playerClass: String?
    //В img и imgGold хранится ссылка на картинку
    var img: String?
    var imgGold: String?
    var locale: String?
}

//Структура рубашки
struct hsCardBack: Codable{
    var cardBackId: String?
    var name: String?
    var description: String?
    var source: String?
    var howToGet: String?
    var enabled: Bool?
    var img: String?
    var imgAnimated: String?
    var sortCategory: String?
    var sortOrder: String?
    var locale: String?
}
