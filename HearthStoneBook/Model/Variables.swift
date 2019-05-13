//
//  Variables.swift
//  HearthStoneBook
//
//  Created by Даниил on 09/05/2019.
//  Copyright © 2019 Даниил. All rights reserved.
//

import Foundation
import UIKit

//Переменная для хранения ссылки на картинку при запросе карты по имени. Вторая для хранения картинки золотой карты.
var searchCard: hsCard = hsCard()
//В переменной хранятся карты при запросе по классу.
var searchCardsOfClass: [hsCard]? = []

//Массив найденых по запросу рубашек
var cardBacks: [hsCardBack]? = []
var cardBacksIndex: Int?

var cardSets: [String] = ["Basic", "Classic", "Credits", "Naxxramas", "Debug", "Goblins vs Gnomes", "Missions", "Promotion", "Reward", "System", "Blackrock Mountain", "Tavern Brawl", "The Grand Tournament"]

//Хедеры для запроса к API
var hsHeaders:[String:String] = [
    "X-RapidAPI-Host": "omgvamp-hearthstone-v1.p.rapidapi.com",
    "X-RapidAPI-Key": "6b60a260cdmsh03b9e96dedac530p14cb9ajsnf28d54dd49d0"
]
//Стандартный URL в виде строки, который будет модернизироваться в зависимости от запроса
var hsURLString = "https://omgvamp-hearthstone-v1.p.rapidapi.com/"

//Массив рубашек для отрисовки в collection
var cardBacksImages: [UIImage] = []
