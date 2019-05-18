//
//  StartViewController.swift
//  HearthStoneBook
//
//  Created by Даниил on 18/04/2019.
//  Copyright © 2019 Даниил. All rights reserved.
//

import UIKit
import RealmSwift

class StartViewController: UIViewController {
    
    @IBOutlet weak var cardsButton: UIButton!
    @IBOutlet weak var cardBacksButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var heroesButton: UIButton!
    @IBOutlet weak var menuLabel: UILabel!
    //Выход из приложения
    @IBAction func exitAction(_ sender: Any) {
        exit(0)
    }
    
    @IBAction func cardsBacksButtonAction(_ sender: Any) {
        let addPart = "cardbacks"
        let cardBacksURL = URL(string: hsURLString + addPart)
        
        let hsRequest = setRequest(URL: cardBacksURL!)
        
        let myResponse = URLSession.shared.dataTask(with: hsRequest, completionHandler: {data, response, error in
            if error == nil {
                do {
                    //MARK: Парсинг полученной структурки в структурку hsCardsBack
                    let json = try JSONDecoder().decode([hsCardBack].self, from: data!)
                    DispatchQueue.main.async {
                        cardBacks = checkCardsWOImage(sourceArray: json)
                        
                        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                        guard let destViewController = mainStoryboard.instantiateViewController(withIdentifier: "CardBacksViewController") as? CardBacksViewController  else {
                            return
                        }
                        destViewController.modalTransitionStyle = .crossDissolve
                        self.present(destViewController, animated: true, completion: nil)
                    }
                } catch {
                    print(error)
                }
            } else {
                print(error ?? "Undefined error")
            }
        }
        )
        myResponse.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //cardsButton.titleLabel?.adjustsFontSizeToFitWidth = true
        //menuLabel.sizeToFit()
        
        //let card = SingleCard()
        let realm = try! Realm()
        let result = realm.objects(SingleCard.self)
        print(result)
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
