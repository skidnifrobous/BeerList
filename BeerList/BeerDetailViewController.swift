//
//  BeerDetailViewController.swift
//  BeerList
//
//  Created by Yuri Ramos on 22/04/17.
//  Copyright © 2017 Yuri Ramos. All rights reserved.
//

import UIKit
import AlamofireImage

protocol BeerDetailViewInterface {
    func fillUpBeerData()
    func setFavoriteButtonSelected()
}

class BeerDetailViewController: UIViewController, BeerDetailViewInterface {

    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var sloganLabel : UILabel!
    @IBOutlet weak var descriptionLabel : UILabel!
    @IBOutlet weak var favoriteButton : UIButton!
    
    var presenter : BeerDetailModuleInterface!
    var selectedBeer : Beer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView() {
        //Setting arquiteture
        let presenter = BeerDetailPresenter()
        let interactor = BeerDetailInteractor()
        let router = BeerDetailRouter()
        
        presenter.view = self
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter
        router.beerDetailViewController = self
        self.presenter = presenter
        
        //Setting custom back button
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(backButtonPressed))
        backButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = backButton
        
        //Setting title
        self.title = "Beer Details"
    }

    func fillUpBeerData() {
        //Set the image
        let imageUrl = URL(string: selectedBeer.imageUrl)!
        imageView.af_setImage(withURL: imageUrl, placeholderImage: #imageLiteral(resourceName: "placeHolder"))
        
        //set the labels
        nameLabel.text = selectedBeer.name
        sloganLabel.text = selectedBeer.tagline
        descriptionLabel.text = selectedBeer.description
        
        //set the favorite button selection
        favoriteButton.isSelected = selectedBeer.isFavorite()
    }
    
    func setFavoriteButtonSelected() {
        favoriteButton.isSelected = selectedBeer.isFavorite()
    }
    
    func backButtonPressed() {
        presenter.didPressedBack()
    }
    
    @IBAction func favoriteButtonPressed(sender:UIButton) {
        if sender.isSelected {
            presenter.didUnfavorite(beer: selectedBeer)
        } else {
            presenter.didFavorite(beer: selectedBeer)
        }
    }

}
