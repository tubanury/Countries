//
//  ViewController.swift
//  Countries
//
//  Created by Tuba N. Yıldız on 14.03.2022.
//

import UIKit

class ViewController: UITabBarController {
   
    let home = UINavigationController(rootViewController: CountryViewController())
    let saved = UINavigationController(rootViewController: SavedCountryController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Countries"
       
        
        home.title = "Home"
        saved.title = "Saved"
        
        self.setViewControllers([home, saved], animated: false)
        
        guard let items = self.tabBar.items else {return}
        
        let images = ["house", "heart"]
        for x in 0...1 {
            items[x].image = UIImage(systemName: images[x])
        }
        
        self.tabBar.tintColor = .black
        self.tabBar.backgroundColor = .gray
    }
    
}
