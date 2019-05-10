//
//  CardBackCollectionViewCell.swift
//  HearthStoneBook
//
//  Created by Даниил on 26/04/2019.
//  Copyright © 2019 Даниил. All rights reserved.
//

import UIKit

class CardBackCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardBackCollectionViewCellImage: UIImageView!
    override func prepareForReuse() {
        super.prepareForReuse()
        for currView in self.subviews
        {
            currView.clearsContextBeforeDrawing = true
            currView.removeFromSuperview()
        }
    }
}
