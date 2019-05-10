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
        
        //Делаю небезопасно, так как сюда зайдет программма только если что-то пользователь выберет и индекс точно будет известен
        //TODO: Когда буду работать через бд, то картинку брать из бд, а не грузить заново
        if let image = cardBacks?[cardBacksIndex!].img{
            //backImageView.downloaded(from: image)
            let url = URL(string: image)
            backImageView.kf.setImage(with: url)
        }
        nameLabel.text = cardBacks?[cardBacksIndex!].name
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
