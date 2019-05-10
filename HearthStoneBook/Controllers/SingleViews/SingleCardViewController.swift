//
//  SingleCardViewController.swift
//  HearthStoneBook
//
//  Created by Даниил on 20/04/2019.
//  Copyright © 2019 Даниил. All rights reserved.
//

import UIKit

class SingleCardViewController: UIViewController {

    @IBOutlet weak var goldImageView: UIImageView!
    @IBOutlet weak var commonImageView: UIImageView!
    @IBOutlet weak var singleCardBackButton: UIButton!
    @IBOutlet weak var singleCardLabel: UILabel!
    @IBAction func singleCardBackButtonAction(_ sender: Any) {
//        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        guard let destViewController = mainStoryboard.instantiateViewController(withIdentifier: "StartViewController") as? StartViewController  else {
//            return
//        }
//        destViewController.modalTransitionStyle = .crossDissolve
//        self.present(destViewController, animated: true, completion: nil)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //MARK: Отображение картинок
        if let image = searchCardImage, let goldImage = searchCardGoldImage{
            commonImageView.downloaded(from: image)
            goldImageView.downloaded(from: goldImage)
        }
        
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
