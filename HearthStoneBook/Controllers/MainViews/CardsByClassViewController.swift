//
//  CardsByClassViewController.swift
//  HearthStoneBook
//
//  Created by Даниил on 26/04/2019.
//  Copyright © 2019 Даниил. All rights reserved.
//

import UIKit
import Kingfisher

class CardsByClassViewController: UIViewController {
    
    @IBOutlet weak var cardsByClassCollectionView: UICollectionView!
    @IBOutlet weak var cardsByClassLabel: UILabel!
    @IBOutlet weak var cardsByClassBackButton: UIButton!
    
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardsByClassCollectionView.dataSource = self
        cardsByClassCollectionView.delegate = self
    }
    
}

extension CardsByClassViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchCardsOfClass?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = cardsByClassCollectionView.dequeueReusableCell(withReuseIdentifier: "CardsCell", for: indexPath) as? CardCollectionViewCell{
            
            if let image = searchCardsOfClass?[indexPath.row].img{
                let url = URL(string: image)
                cell.cardCollectionViewCellImage.kf.indicatorType = .activity
                cell.cardCollectionViewCellImage.kf.setImage(with: url, options: [.onFailureImage(UIImage(named: "error.png"))]){result in
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(_): break
                    }
                }
            }
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let singleStoryboard = UIStoryboard(name: "SingleViews", bundle: Bundle.main)
        guard let destViewController = singleStoryboard.instantiateViewController(withIdentifier: "SingleCardOfClassViewController") as? SingleCardOfClassViewController else{
            return
        }
        
        selectedCardOfClass = searchCardsOfClass?[indexPath.row] ?? hsCard()
        
        destViewController.cardIndex = indexPath.row
        destViewController.modalTransitionStyle = .crossDissolve
        present(destViewController, animated: true, completion: nil)
    }
}
