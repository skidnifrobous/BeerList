//
//  BeerInteractor.swift
//  BeerList
//
//  Created by Yuri Ramos on 20/04/17.
//  Copyright © 2017 Yuri Ramos. All rights reserved.
//

import Foundation


protocol BeersInteractorInput {
    
    func fetchBeers(page:Int, filter: String)
    func setFavorite(beer:Beer, fav:Bool)
    
}

class BeersInteractor: BeersInteractorInput {
    
    var output : BeersInteractorOutput!
    
    func fetchBeers(page: Int, filter: String) {
        AFRouter.getBeers(page: page, filter: filter, completionHandler: { (beers) in
            if page == 1 {
                self.output.beersFetched(beers)
            } else {
                self.output.moreBeersFetched(beers)
            }
        }) { (error) in
            self.output.beerFetchFail()
        }
    }
    
    func setFavorite(beer:Beer, fav: Bool) {
        beer.setFavorite(fav: fav)
    }
}
