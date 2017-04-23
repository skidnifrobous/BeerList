//
//  BeerDetailPresenter.swift
//  BeerList
//
//  Created by Yuri Ramos on 22/04/17.
//  Copyright © 2017 Yuri Ramos. All rights reserved.
//

import Foundation

protocol BeerDetailModuleInterface {
    func viewDidLoad()
    func didFavorite(beer:Beer)
    func didUnfavorite(beer:Beer)
    func didPressedBack()
}

protocol BeerDetailInteractorOutput {
    func beerFavoriteSet()
}

class BeerDetailPresenter: BeerDetailModuleInterface, BeerDetailInteractorOutput {
    
    weak var view: BeerDetailViewController?
    var interactor : BeerDetailInteractorInput!
    var router : BeerDetailWireframe!
    
    func viewDidLoad() {
        view?.fillUpBeerData()
    }
    
    func didFavorite(beer: Beer) {
        interactor.setBeerFavorite(true, beer: beer)
    }
    
    func didUnfavorite(beer: Beer) {
        interactor.setBeerFavorite(false, beer: beer)
    }
    
    func didPressedBack() {
        router.backToBeerList()
    }
    
    func beerFavoriteSet() {
        view?.setFavoriteButtonSelected()
    }
}
