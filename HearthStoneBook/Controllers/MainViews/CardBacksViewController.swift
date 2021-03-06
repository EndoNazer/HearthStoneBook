//
//  CardBacksViewController.swift
//  HearthStoneBook
//
//  Created by Даниил on 12/05/2019.
//  Copyright © 2019 Даниил. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class CardBacksViewController: UIViewController {
    
    
    @IBOutlet weak var cardBacksCollectionView: UICollectionView!
    @IBOutlet weak var cardBacksLabel: UILabel!
    @IBOutlet weak var backCardBacksButton: UIButton!
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardBacksCollectionView.dataSource = self
        cardBacksCollectionView.delegate = self
    }
}

extension CardBacksViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardBacks?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = cardBacksCollectionView.dequeueReusableCell(withReuseIdentifier: "CardBacksCell", for: indexPath) as? CardBackCollectionViewCell{
            
            if let image = cardBacks?[indexPath.row].img{
                let url = URL(string: image)
                cell.cardBackCollectionViewCellImage.kf.indicatorType = .activity
                cell.cardBackCollectionViewCellImage.kf.setImage(with: url, options: [.onFailureImage(UIImage(named: "error.png"))]){result in
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(_): break
                    }
                }
            }
            //print("\(indexPath.row) \(Unmanaged.passUnretained(cell).toOpaque())")
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let singleStoryboard = UIStoryboard(name: "SingleViews", bundle: Bundle.main)
        guard let destViewController = singleStoryboard.instantiateViewController(withIdentifier: "SingleCardBackViewController") as? SingleCardBackViewController else{
            return
        }
        destViewController.cardBack = cardBacks?[indexPath.row] ?? hsCardBack()
        destViewController.modalTransitionStyle = .crossDissolve
        self.present(destViewController, animated: true, completion: nil)
    }
}
