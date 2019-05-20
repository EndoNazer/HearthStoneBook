//
//  CardsViewController.swift
//  HearthStoneBook
//
//  Created by Даниил on 19/04/2019.
//  Copyright © 2019 Даниил. All rights reserved.
//

import UIKit
import RealmSwift

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
                //MARK: Проверка на наличие карты в базе Realm
                let cardCheck = SingleCard()
                cardCheck.name = name
                do{
                    let realm = try Realm()
                    //MARK: Добавление размытия и индикатора
                    blurAndActivityEffectAdd(viewController: self)
                    if let check = realm.object(ofType: SingleCard.self, forPrimaryKey: cardCheck.name){
                        //MARK: Удаление размытия и индикатора
                        blurAndActivityEffectRemove(viewController: self)
                        //MARK: Переход на одиночную вьюху
                        let singleStoryboard = UIStoryboard(name: "SingleViews", bundle: Bundle.main)
                        guard let destViewController = singleStoryboard.instantiateViewController(withIdentifier: "SingleCardViewController") as? SingleCardViewController  else {
                            return
                        }
                        destViewController.img = String(data: check.img!, encoding: .utf8)!
                        destViewController.imgGold = String(data: check.imgGold!, encoding: .utf8)!
                        destViewController.name = check.name
                        destViewController.modalTransitionStyle = .crossDissolve
                        self.present(destViewController, animated: true, completion: nil)
                    }else{
                        //MARK: Замена пробелов в названии карты
                        let nameWOSpaces = name.replacingOccurrences(of: " ", with: "%20")
                        
                        //MARK: Формирую строку запроса на основе введенного названия карты
                        let formStr = "cards/\(nameWOSpaces)"
                        let addPart = formStr.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                        let nameCardsURL = URL(string: hsURLString + addPart!)
                        
                        let hsRequest = setRequest(URL: nameCardsURL!)
                        
                        let request = URLSession.shared.dataTask(with: hsRequest, completionHandler: {data, response, error in
                            if error == nil {
                                do {
                                    //MARK: Парсинг полученной структурки в структурку hsCard
                                    let json = try JSONDecoder().decode([hsCard].self, from: data!)
                                    DispatchQueue.main.async {
                                        //MARK: Удаление размытия и индикатора
                                        blurAndActivityEffectRemove(viewController: self)
                                        searchCard = json.map({ (card: hsCard) in return card}).first ?? hsCard()
                                        
                                        //MARK: Создание объекта Realm и переход на новую View
                                        if  let cardName = searchCard.name, let imgStr = searchCard.img, let imgGoldStr = searchCard.imgGold{
                                            if let imgData = imgStr.data(using: .utf8), let imgGoldData = imgGoldStr.data(using: .utf8){
                                                let cardObj = SingleCard()
                                                cardObj.name = cardName
                                                cardObj.img = imgData
                                                cardObj.imgGold = imgGoldData
                                                
                                                let realm = try! Realm()
                                                try! realm.write {
                                                    realm.add(cardObj)
                                                }
                                            }
                                            //MARK: Переход на одиночную вьюху
                                            let singleStoryboard = UIStoryboard(name: "SingleViews", bundle: Bundle.main)
                                            guard let destViewController = singleStoryboard.instantiateViewController(withIdentifier: "SingleCardViewController") as? SingleCardViewController  else {
                                                return
                                            }
                                            destViewController.img = imgStr
                                            destViewController.imgGold = imgGoldStr
                                            destViewController.name = cardName
                                            destViewController.modalTransitionStyle = .crossDissolve
                                            self.present(destViewController, animated: true, completion: nil)
                                        }
                                    }
                                } catch {
                                    print(error)
                                    DispatchQueue.main.sync {
                                        //MARK: Удаление размытия и индикатора
                                        blurAndActivityEffectRemove(viewController: self)
                                        
                                        self.nameCardsBox.text = nil
                                        self.nameCardsBox.attributedPlaceholder = NSAttributedString(string:"Enter correct name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                                    }
                                }
                            } else {
                                print(error ?? "Undefined error")
                                //MARK: Удаление размытия и индикатора
                                blurAndActivityEffectRemove(viewController: self)
                            }
                        })
                        request.resume()
                    }
                }catch let error as NSError{
                    print(error)
                }
            }else{
                //MARK: Если пользователь ничего не ввел в TextField
                nameCardsBox.text = nil
                self.nameCardsBox.attributedPlaceholder = NSAttributedString(string:"Please enter the name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            }
        }
    }
    //Поиск по классу
    @IBAction func classCardsSearchAction(_ sender: Any) {
        if let classCard = classCardsBox.text{
            if classCard != ""{
                //MARK: Формирую строку запроса на основе введенного названия карты
                let formStr = "cards/classes/\(classCard)"
                let addPart = formStr.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                let classCardsURL = URL(string: hsURLString + addPart!)
                //MARK: Создание запроса
                let hsRequest = setRequest(URL: classCardsURL!)
                //MARK: Добавление размытия и индикатора
                blurAndActivityEffectAdd(viewController: self)
                //MARK: Поиск по классу
                gettingResponseSearchClass(request: hsRequest, viewController: self, cardBox: classCardsBox)
            }else{
                classCardsBox.text = nil
                self.classCardsBox.attributedPlaceholder = NSAttributedString(string:"Please enter the class", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }    
}
