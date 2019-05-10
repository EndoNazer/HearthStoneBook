//
//  CardBacksViewController.swift
//  HearthStoneBook
//
//  Created by Даниил on 19/04/2019.
//  Copyright © 2019 Даниил. All rights reserved.
//

import UIKit
import Kingfisher

class CardBacksViewController: UIViewController {

   
    @IBOutlet weak var cardBacksCollectionView: UICollectionView!
    @IBOutlet weak var cardBacksLabel: UILabel!
    @IBOutlet weak var backCardBacksButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //cardBacksCollectionView.isPrefetchingEnabled = false
        //cardBacksCollectionView.prefetchDataSource = cardBacks as? UICollectionViewDataSourcePrefetching
        
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
                cell.cardBackCollectionViewCellImage.downloaded(from: image)
                //let url = URL(string: image)
                //cell.cardBackCollectionViewCellImage.kf.setImage(with: url)
            }
            print("\(indexPath.row) \(Unmanaged.passUnretained(cell).toOpaque())")
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print(indexPath.row)
        let singleStoryboard = UIStoryboard(name: "SingleViews", bundle: Bundle.main)
        guard let destViewController = singleStoryboard.instantiateViewController(withIdentifier: "SingleCardBackViewController") as? SingleCardBackViewController else{
            return
        }
        
        cardBacksIndex = indexPath.row
        destViewController.modalTransitionStyle = .crossDissolve
        present(destViewController, animated: true, completion: nil)
    }
}
