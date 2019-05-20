//
//  Functions.swift
//  HearthStoneBook
//
//  Created by Даниил on 09/05/2019.
//  Copyright © 2019 Даниил. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import RealmSwift

//MARK: Функции для проверки на наличие картинки
func checkCardsWOImage(sourceArray: [hsCard]) -> [hsCard]{
    var array: [hsCard] = []
    for someCard in sourceArray{
        if someCard.img != nil{
            array.append(someCard)
        }
    }
    return array
}
func checkCardsWOImage(sourceArray: [hsCardBack]) -> [hsCardBack]{
    var array: [hsCardBack] = []
    for someCard in sourceArray{
        if someCard.img != nil{
            array.append(someCard)
        }
    }
    return array
}
//MARK: Удаление карт типа Hero
func deleteCardHeroType(sourceArray: [hsCard]) -> [hsCard]{
    var array: [hsCard] = []
    for someCard in sourceArray{
        if someCard.type != "Hero"{
            array.append(someCard)
        }
    }
    return array
}
//MARK: Удаление карт без типа
func deleteCardMissingType(sourceArray: [hsCard]) -> [hsCard]{
    var array: [hsCard] = []
    for someCard in sourceArray{
        if cardSets.contains(someCard.cardSet ?? ""){
            array.append(someCard)
        }
    }
    return array
}

//MARK: Создание запроса к API
func setRequest(URL: URL) -> URLRequest{
    var hsRequest = URLRequest(url: URL)
    hsRequest.allHTTPHeaderFields = hsHeaders
    hsRequest.httpMethod = "GET"
    hsRequest.httpBody = Data()
    hsRequest.addValue("contentType", forHTTPHeaderField: "Application/JSON")
    
    return hsRequest
}

//MARK: Функция для поиска по классу
func gettingResponseSearchClass(request: URLRequest, viewController: UIViewController, cardBox: UITextField){
    let request = URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
        if error == nil {
            do {
                //MARK: Парсинг полученной структурки в структурку hsCard
                let json = try JSONDecoder().decode([hsCard].self, from: data!)
                DispatchQueue.main.async {
                    //MARK: Удаление размытия и индикатора
                    blurAndActivityEffectRemove(viewController: viewController)
                    //MARK: Отбор карт с картинками. То что без картинок отсеить.
                    let cardsWOImage = checkCardsWOImage(sourceArray: json)
                    //MARK: Удаление отсутствующих дополнений
                    let cardsOfTheNecessaryTypes = deleteCardHeroType(sourceArray: cardsWOImage)
                    searchCardsOfClass = deleteCardMissingType(sourceArray: cardsOfTheNecessaryTypes)
                    //MARK: Переход на вьюху с полученными картонками(картами)
                    let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    guard let destViewController = mainStoryboard.instantiateViewController(withIdentifier: "CardsByClassViewController") as? CardsByClassViewController  else {
                        return
                    }
                    destViewController.modalTransitionStyle = .crossDissolve
                    viewController.present(destViewController, animated: true, completion: nil)
                }
            } catch {
                print(error)
                DispatchQueue.main.sync {
                    //MARK: Удаление размытия и индикатора
                    blurAndActivityEffectRemove(viewController: viewController)
                    
                    cardBox.text = nil
                    cardBox.attributedPlaceholder = NSAttributedString(string:"Enter correct class", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                }
            }
        } else {
            print(error ?? "Undefined error")
            //MARK: Удаление размытия и индикатора
            blurAndActivityEffectRemove(viewController: viewController)
        }
    })
    request.resume()
}

//MARK: Функция для отображения картинок и имени карты в SingleView
func displayCardImages(img: String, imgGold: String, name: String, commonImgView: UIImageView, goldImgView: UIImageView, nameLabel: UILabel){
    let urlCommon = URL(string: img)
    let urlGold = URL(string: imgGold)
    
    commonImgView.kf.indicatorType = .activity
    goldImgView.kf.indicatorType = .activity
    
    commonImgView.kf.setImage(with: urlCommon, options: [.onFailureImage(UIImage(named: "error.png"))])
    goldImgView.kf.setImage(with: urlGold, options: [.onFailureImage(UIImage(named: "error.png"))])
    nameLabel.text = name
}
//MARK: Функция для отображения картинки и имени рубашки в SingleView
func displayCardBackImages(backImg: String, name: String, backImgView: UIImageView, nameLabel: UILabel){
    let url = URL(string: backImg)
    backImgView.kf.setImage(with: url, options: [.onFailureImage(UIImage(named: "error.png"))])
    nameLabel.text = name
}

//MARK: Добавление блюра и индикатора загрузки на вью при загрузке данных
func blurAndActivityEffectAdd(viewController: UIViewController){
    
    let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    blurEffectView.tag = 100
    blurEffectView.frame = viewController.view.bounds
    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
    let activityView = UIActivityIndicatorView(frame: blurEffectView.frame)
    activityView.style = .whiteLarge
    activityView.tag = 101
    activityView.isHidden = false
    activityView.startAnimating()
    
    viewController.view.addSubview(blurEffectView)
    viewController.view.addSubview(activityView)
}
//MARK: Удаление блюра и индикатора загрузки на вью при загрузке данных
func blurAndActivityEffectRemove(viewController: UIViewController){
    if let blurEffectView = viewController.view.viewWithTag(100),
        let activityIndicator = viewController.view.viewWithTag(101){
            blurEffectView.removeFromSuperview()
            activityIndicator.removeFromSuperview()
    }
}
//MARK: Расширение для вставки картинок в ImageView
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
