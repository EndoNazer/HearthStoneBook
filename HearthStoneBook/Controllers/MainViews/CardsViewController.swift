//
//  CardsViewController.swift
//  HearthStoneBook
//
//  Created by Даниил on 19/04/2019.
//  Copyright © 2019 Даниил. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
    
    @IBOutlet weak var backCardsButton: UIButton!
    @IBOutlet weak var nameCardsBox: UITextField!
    @IBOutlet weak var classCardsBox: UITextField!
    @IBOutlet weak var nameCardsSearchButton: UIButton!
    @IBOutlet weak var classCardsSearchButton: UIButton!
    @IBOutlet weak var cardsLabel: UILabel!
    //MARK: Actions кнопок поиска карт
    //Поиск по имени
    @IBAction func nameCardsSearchAction(_ sender: Any) {
        if let name = nameCardsBox.text{
            if name != ""{
                let nameWOSpaces = name.replacingOccurrences(of: " ", with: "%20")

                //MARK: Формирую строку запроса на основе введенного названия карты
                let addPart = "cards/\(nameWOSpaces)"
                let nameCardsURL = URL(string: hsURLString + addPart)

                let hsRequest = setRequest(URL: nameCardsURL!)
                
                let request = URLSession.shared.dataTask(with: hsRequest, completionHandler: {data, response, error in
                    if error == nil {
                        do {
                            //MARK: Парсинг полученной структурки в структурку hsCard
                            let json = try JSONDecoder().decode([hsCard].self, from: data!)
                            DispatchQueue.main.async {
                                searchCard = json.map({ (card: hsCard) in return card}).first ?? hsCard()
                                //MARK: Переход на одиночную вьюху
                                let singleStoryboard = UIStoryboard(name: "SingleViews", bundle: Bundle.main)
                                guard let destViewController = singleStoryboard.instantiateViewController(withIdentifier: "SingleCardViewController") as? SingleCardViewController  else {
                                    return
                                }
                                destViewController.modalTransitionStyle = .crossDissolve
                                self.present(destViewController, animated: true, completion: nil)
                            }
                        } catch {
                            print(error)
                            DispatchQueue.main.sync {
                                self.nameCardsBox.text = nil
                                self.nameCardsBox.attributedPlaceholder = NSAttributedString(string:"Enter correct name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                            }
                        }
                    } else {
                        print(error ?? "Undefined error")
                    }
                    }
                )
                request.resume()
            }else{
                //MARK: Если пользователь ничего не ввел в TextField
                nameCardsBox.text = nil
                nameCardsBox.placeholder = "Please enter the name"
            }
        }
    }
    //Поиск по классу
    @IBAction func classCardsSearchAction(_ sender: Any) {
        if let classCard = classCardsBox.text{
            if classCard != ""{
                //MARK: Формирую строку запроса на основе введенного названия карты
                let addPart = "cards/classes/\(classCard)"
                let classCardsURL = URL(string: hsURLString + addPart)
                
                //TODO: При вводе на русском выдает nil
                let hsRequest = setRequest(URL: classCardsURL!)
                
                let request = URLSession.shared.dataTask(with: hsRequest, completionHandler: {data, response, error in
                    if error == nil {
                        do {
                            //MARK: Парсинг полученной структурки в структурку hsCard
                            let json = try JSONDecoder().decode([hsCard].self, from: data!)
                            DispatchQueue.main.async {
                                //MARK: отбор карт с картинками. То что без картинок отсеить. В идеале модернизировать как-то, чтобы отображать те карты, у которых нет картинок.
                                let cardsWOImage = checkCardsWOImage(sourceArray: json)
                                //Удаление отсутствующих дополнений
                                let cardsOfTheNecessaryTypes = deleteCardHeroType(sourceArray: cardsWOImage)
                                searchCardsOfClass = deleteCardMissingType(sourceArray: cardsOfTheNecessaryTypes)
                                //MARK: Переход на вьюху с полученными картонками(картами)
                                let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                guard let destViewController = mainStoryboard.instantiateViewController(withIdentifier: "CardsByClassViewController") as? CardsByClassViewController  else {
                                    return
                                }
                                destViewController.modalTransitionStyle = .crossDissolve
                                self.present(destViewController, animated: true, completion: nil)
                            }
                        } catch {
                            print(error)
                            DispatchQueue.main.sync {
                                self.classCardsBox.text = nil
                                self.classCardsBox.attributedPlaceholder = NSAttributedString(string:"Enter correct class", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                            }
                        }
                    } else {
                        print(error ?? "Undefined error")
                    }
                })
                request.resume()

            }else{
                classCardsBox.text = nil
                classCardsBox.placeholder = "Please enter the class"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
