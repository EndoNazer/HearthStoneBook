//
//  SingleCardBackViewController.swift
//  HearthStoneBook
//
//  Created by Даниил on 20/04/2019.
//  Copyright © 2019 Даниил. All rights reserved.
//

import UIKit
import Kingfisher

class SingleCardBackViewController: UIViewController {

    var cardBack: hsCardBack = hsCardBack()
    
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var backToMenuButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBAction func backToMenuButtonAction(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let destViewController = mainStoryboard.instantiateViewController(withIdentifier: "StartViewController") as? StartViewController else{
            return
        }
        destViewController.modalTransitionStyle = .crossDissolve
        present(destViewController, animated: true, completion: nil)
    }
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = cardBack.img, let name = cardBack.name{
            displayCardBackImages(backImg: image, name: name, backImgView: backImageView, nameLabel: nameLabel)
        }
    }
}
