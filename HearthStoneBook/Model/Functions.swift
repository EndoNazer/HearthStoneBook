//
//  Functions.swift
//  HearthStoneBook
//
//  Created by Даниил on 09/05/2019.
//  Copyright © 2019 Даниил. All rights reserved.
//

import Foundation
import UIKit

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

func deleteCardHeroType(sourceArray: [hsCard]) -> [hsCard]{
    var array: [hsCard] = []
    for someCard in sourceArray{
        if someCard.type != "Hero"{
            array.append(someCard)
        }
    }
    return array
}

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
    //TODO: При неверном имени карты выдает ошибку, так как nil. Исправить!
    var hsRequest = URLRequest(url: URL)
    hsRequest.allHTTPHeaderFields = hsHeaders
    hsRequest.httpMethod = "GET"
    hsRequest.httpBody = Data()
    hsRequest.addValue("contentType", forHTTPHeaderField: "Application/JSON")
    
    return hsRequest
}

func cardBacksLoad(request: URLRequest){
    let myResponse = URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
        if error == nil {
            do {
                //MARK: Парсинг полученной структурки в структурку hsCardsBack
                let json = try JSONDecoder().decode([hsCardBack].self, from: data!)
                DispatchQueue.main.async {
                    cardBacks = checkCardsWOImage(sourceArray: json)
                    
                    //MARK: Переход на одиночную вьюху
                    let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    guard let destViewController = mainStoryboard.instantiateViewController(withIdentifier: "CardBacksViewController") as? CardBacksViewController  else {
                        return
                    }
                    destViewController.modalTransitionStyle = .crossDissolve
                    StartViewController().present(destViewController, animated: true, completion: nil)
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
