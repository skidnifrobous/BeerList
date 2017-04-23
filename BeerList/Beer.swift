//
//  Beer.swift
//  BeerList
//
//  Created by Yuri Ramos on 20/04/17.
//  Copyright © 2017 Yuri Ramos. All rights reserved.
//

import Foundation

struct Beer {
    let id : Int
    let name : String
    let abv : Double
    let tagline : String
    let description : String
    let imageUrl : String
    
    init(id : Int, name: String, abv: Double, tagline: String, description: String, imageUrl: String) {
        self.id = id
        self.name = name
        self.abv = abv
        self.tagline = tagline
        self.description = description
        self.imageUrl = imageUrl
    }
    
    func isFavorite() -> Bool {
        return UserDefaults.standard.bool(forKey: "Beer_\(self.id)")
    }
    
    func setFavorite(fav: Bool) {
        UserDefaults.standard.set(fav, forKey: "Beer_\(self.id)")
    }
}
