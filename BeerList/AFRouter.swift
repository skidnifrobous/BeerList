//
//  AFRouter.swift
//  BeerList
//
//  Created by Yuri Ramos on 21/04/17.
//  Copyright © 2017 Yuri Ramos. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

let API = "https://api.punkapi.com/v2/"
let BEER_PATH = "beers/"

class AFRouter {
    
    static func getBeers(page:Int, filter:String, completionHandler:@escaping (_ beer:[Beer])->(), errorHandler:@escaping (_ error: Error)->()) {
        
        let path = API + BEER_PATH
        var params = ["page":"\(page)"]
        if !filter.isEmpty {
            params["beer_name"] = filter
        }
        
        Alamofire.request(path, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (responseData) in
            switch responseData.result {
            case .success(let value):
                let json = JSON(value)
                var beers = [Beer]()
                for j in json.arrayValue {
                    beers.append(convertJsonToBeer(j))
                }
                completionHandler(beers)
            case .failure(let error):
                errorHandler(error)
            }
        }
    }
    
    static func convertJsonToBeer(_ json:JSON) -> Beer {
        let beer = Beer(id: json["id"].intValue, name: json["name"].stringValue, abv: json["abv"].doubleValue, tagline: json["tagline"].stringValue, description: json["description"].stringValue, imageUrl: json["image_url"].stringValue)
        return beer
    }
}
