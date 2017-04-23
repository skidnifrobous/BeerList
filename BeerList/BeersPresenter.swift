//
//  BeerPresenter.swift
//  BeerList
//
//  Created by Yuri Ramos on 20/04/17.
//  Copyright © 2017 Yuri Ramos. All rights reserved.
//

import Foundation

protocol BeersModuleInterface {
    func viewDidLoad()
    func didSelectBeer(_ beer:Beer)
    func didFilterBeer(_ filter:String)
    func didTryAgain(_ filter:String)
    func willDisplayLastCell(_ filter: String)
}

protocol BeersInteractorOutput {
    func beersFetched(_ beers:[Beer])
    func moreBeersFetched(_ beers:[Beer])
    func beerFetchFail()
}

class BeersPresenter: BeersModuleInterface {
    weak var view: BeersViewController?
    var interactor : BeersInteractorInput!
    var router : BeersWireframe!
    
    var page = 1
    var canLoadMore = true
    
    func viewDidLoad() {
        loadFirstPage("")
    }
    
    func loadFirstPage(_ filter:String) {
        page = 1
        canLoadMore = true
        interactor.fetchBeers(page: page, filter: filter)
    }
    
    func loadNextPage(_ filter:String) {
        page += 1
        canLoadMore = false
        interactor.fetchBeers(page: page, filter: filter)
    }
    
    func didSelectBeer(_ beer: Beer) {
        router.presentBeerDetail(beer: beer)
    }
    
    func didFilterBeer(_ filter: String) {
        loadFirstPage(filter)
    }
    
    func didTryAgain(_ filter: String) {
        loadFirstPage(filter)
    }
    
    func willDisplayLastCell(_ filter:String) {
        if canLoadMore {
            loadNextPage(filter)
        }
    }
    
}

extension BeersPresenter: BeersInteractorOutput {
    func beersFetched(_ beers: [Beer]) {
        if beers.count > 0 {
            view?.showBeerList(beers)
        } else {
            view?.showNoContentMessage()
        }
    }
    
    func moreBeersFetched(_ beers: [Beer]) {
        view?.appendBeers(beers)
        canLoadMore = true
    }
    
    func beerFetchFail() {
        self.view?.showNoConectionMessage()
    }
}
