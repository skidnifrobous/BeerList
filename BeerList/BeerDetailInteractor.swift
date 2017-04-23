//
//  BeerDetailInteractor.swift
//  BeerList
//
//  Created by Yuri Ramos on 22/04/17.
//  Copyright © 2017 Yuri Ramos. All rights reserved.
//

import Foundation

protocol BeerDetailInteractorInput {
    func setBeerFavorite(_ fav:Bool, beer:Beer)
}

class BeerDetailInteractor: BeerDetailInteractorInput {
    var output : BeerDetailInteractorOutput!
    
    func setBeerFavorite(_ fav: Bool, beer: Beer) {
        beer.setFavorite(fav: fav)
        output.beerFavoriteSet()
    }
}
