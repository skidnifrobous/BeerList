//
//  BeerRouter.swift
//  BeerList
//
//  Created by Yuri Ramos on 20/04/17.
//  Copyright © 2017 Yuri Ramos. All rights reserved.
//

import Foundation
import UIKit

protocol BeersWireframe {
    func presentBeerDetail(beer: Beer)
}

class BeersRouter: BeersWireframe {
    
    weak var beersViewController : BeersViewController!
    var storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    func presentBeerDetail(beer: Beer) {
        let beerDetailViewController = storyboard.instantiateViewController(withIdentifier: "beerDetail") as! BeerDetailViewController
        beerDetailViewController.selectedBeer = beer
        beersViewController.navigationController!.pushViewController(beerDetailViewController, animated: true)
    }
}
