//
//  BeerDetailRouter.swift
//  BeerList
//
//  Created by Yuri Ramos on 22/04/17.
//  Copyright © 2017 Yuri Ramos. All rights reserved.
//

import Foundation
import UIKit

protocol BeerDetailWireframe {
    func backToBeerList()
}

class BeerDetailRouter: BeerDetailWireframe {
    
    weak var beerDetailViewController : BeerDetailViewController!
    
    func backToBeerList() {
        let _ = beerDetailViewController.navigationController!.popViewController(animated: true)
    }
}
