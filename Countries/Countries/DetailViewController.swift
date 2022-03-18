//
//  DetailViewController.swift
//  Countries
//
//  Created by Tuba N. Yıldız on 17.03.2022.
//

import Foundation
import UIKit

class DetailViewController: UIViewController{
    
    
    var detailView = DetailView()
    //var countryCode = ""
    var isFavorited: Bool?
    var countryDetails: CountryDetails?
    let image = UIImage(named: "fav_star")?.withRenderingMode(.alwaysOriginal)
    let favImage = UIImage(named: "fav_star_filled_2")?.withRenderingMode(.alwaysOriginal)
    var url: String?
    
    
    var countryCode: String?{
        didSet{
            DispatchQueue.main.async {
                NetworkService().fetchCountryDetails( countryCode: self.countryCode ?? "") { (countryDetails) in
                    self.countryDetails = countryDetails.data
                    self.url = countryDetails.data.flagImageURI
                    self.detailView.country = countryDetails.data
                   
                    self.title = countryDetails.data.name

                }
            }
            /*if SavedCountryController.favoritedCountries.firstIndex(where: { $0.name == self.countryDetails?.name }) != nil {
               // navigationItem.rightBarButtonItem = UIBarButtonItem(image: favImage, style: .plain, target: self, action: #selector(customButtonTapped))
            }
            else {
                //navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(customButtonTapped))

            }*/
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //DetailView.priceLabel.text = "Country Code: " + countryCode
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(customButtonTapped))
        configureViewComponents()
    }
    
    func configureViewComponents(){
        
       
        detailView.translatesAutoresizingMaskIntoConstraints =  false
        //detailView.country = countryDetails
        view.addSubview(detailView)
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.topAnchor),
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
         
        ])
    }
    
    @objc private func customButtonTapped(){

       /* if let index = SavedCountryController.favoritedCountries.firstIndex(where: { $0.name == self.countryDetails?.name }) {
            let favorite = SavedCountryController.favoritedCountries[index].isFavourite
            let country = Country(isFavourite: favorite, name: self.countryDetails?.name ?? "", countryCode: self.countryDetails?.code ?? "")

            if !favorite {
                navigationItem.rightBarButtonItem = UIBarButtonItem(image: favImage, style: .plain, target: self, action: #selector(customButtonTapped))

                //SavedCountryController.favoritedCountries.append(country)
            }
            else {
                navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(customButtonTapped))

                let index = SavedCountryController.favoritedCountries.firstIndex{ $0.name == country.name }
                if let index = index {
                   // SavedCountryController.favoritedCountries.remove(at: index)
                }
            }

        }
        else {
            return
        }*/
       
    }
}
