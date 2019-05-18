//
//  Objects.swift
//  HearthStoneBook
//
//  Created by Даниил on 16/05/2019.
//  Copyright © 2019 Даниил. All rights reserved.
//

import Foundation
import RealmSwift

class SingleCard: Object{
    @objc dynamic var name = ""
    @objc dynamic var img: Data? = nil
    @objc dynamic var imgGold: Data? = nil
    
    override static func primaryKey() -> String? {
        return "name"
    }
}
