//
//  SingleCardViewController.swift
//  HearthStoneBook
//
//  Created by Даниил on 20/04/2019.
//  Copyright © 2019 Даниил. All rights reserved.
//

import UIKit
import Kingfisher

class SingleCardViewController: UIViewController {
    
    var img: String = ""
    var imgGold: String = ""
    var name: String = ""
    
    @IBOutlet weak var goldImageView: UIImageView!
    @IBOutlet weak var commonImageView: UIImageView!
    @IBOutlet weak var singleCardBackButton: UIButton!
    @IBOutlet weak var singleCardLabel: UILabel!
    @IBOutlet weak var cardNameLabel: UILabel!
    @IBAction func singleCardBackButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Отображение картинок
        displayCardImages(img: self.img, imgGold: self.imgGold, name: self.name, commonImgView: commonImageView, goldImgView: goldImageView, nameLabel: cardNameLabel)
    }
}
