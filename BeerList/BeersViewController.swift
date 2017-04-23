//
//  BeerViewController.swift
//  BeerList
//
//  Created by Yuri Ramos on 20/04/17.
//  Copyright © 2017 Yuri Ramos. All rights reserved.
//

import UIKit
import AlamofireImage

protocol BeersViewInterface {
    func showBeerList(_ beers: [Beer])
    func appendBeers(_ beers: [Beer])
    func showNoContentMessage()
    func showNoConectionMessage()
}

class BeersViewController: UIViewController, BeersViewInterface {
    
    @IBOutlet weak var beersTableView : UITableView!
    @IBOutlet weak var searchField : UITextField!
    
    var presenter : BeersModuleInterface!
    var beers : [Beer] = []

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
        let presenter = BeersPresenter()
        let interactor = BeersInteractor()
        let router = BeersRouter()
        
        presenter.view = self
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter
        router.beersViewController = self
        self.presenter = presenter
        
        //Setting title
        self.title = "Beer List"
        
        //configuring Search Field
        let searchIconIV = UIImageView(image: #imageLiteral(resourceName: "searchIcon"))
        searchIconIV.tintColor = UIColor.white
        searchIconIV.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        searchIconIV.contentMode = .scaleAspectFit
        searchField.leftView = searchIconIV
        searchField.leftViewMode = .always
        searchField.leftView?.transform = CGAffineTransform(translationX: 20, y: 0)
        searchField.attributedPlaceholder = NSAttributedString(string: searchField.placeholder!, attributes: [NSForegroundColorAttributeName: UIColor.white])
        searchField.superview?.layer.cornerRadius = 5
        
        //removing navigation bar shadow
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

    }
    
    func reloadTableViewData(){
        beersTableView.reloadData()
    }
    
    func showBeerList(_ beers: [Beer]) {
        self.beersTableView.alpha = 1
        self.beers = beers
        self.reloadTableViewData()
    }
    
    func appendBeers(_ beers: [Beer]) {
        self.beers.append(contentsOf: beers)
        self.reloadTableViewData()
    }
    
    func showNoContentMessage() {
        self.beersTableView.alpha = 0
    }
    
    func showNoConectionMessage() {
        let alertMessage = UIAlertController(title: "Erro", message: "Não foi possível conectar ao servidor.", preferredStyle: .alert)
        alertMessage.addAction(UIAlertAction(title: "Tentar novamente", style: .default, handler: { (action) in
            self.presenter.didTryAgain(self.searchField.text!)
        }))
        self.present(alertMessage, animated: true, completion: nil)
    }
    
}

extension BeersViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let beer = beers[indexPath.row]
        
        //CELL DEFINED IN STORYBOARD
        let imageView = cell.viewWithTag(1) as! UIImageView
        let nameLabel = cell.viewWithTag(2) as! UILabel
        let abvLabel  = cell.viewWithTag(3) as! UILabel
        
        //Setting image
        let imageUrl = URL(string: beer.imageUrl)!
        imageView.af_setImage(withURL: imageUrl, placeholderImage: #imageLiteral(resourceName: "placeHolder"))
        
        //filling labels
        nameLabel.text = beer.name
        abvLabel.text = "ABV: \(beer.abv)"
        
        return cell
    }
}

extension BeersViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == beers.count - 1 {
            presenter.willDisplayLastCell(searchField.text!)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let beer = beers[indexPath.row]
        presenter.didSelectBeer(beer)
    }
}

extension BeersViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        presenter.didFilterBeer(textField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
