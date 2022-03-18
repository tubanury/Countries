//
//  SavedCountryController.swift
//  Countries
//
//  Created by Tuba N. Yıldız on 16.03.2022.
//

import Foundation


//
//  CountryTable.swift
//  Countries
//
//  Created by Tuba N. Yıldız on 15.03.2022.
//

import Foundation
import UIKit

class SavedCountryController: UITableViewController {

    let cellSpacingHeight: CGFloat = 20
    static var favoritedCountries = [Country]()
  
    
    
    func markFavorite(cell: UITableViewCell){
        
        let indexClicked = tableView.indexPath(for: cell)
        let index = indexClicked?.row
        let isFavorited = CountryViewController.countriesList[index!].isFavourite
        CountryViewController.countriesList[index!].isFavourite = !isFavorited
        cell.accessoryView?.tintColor = isFavorited ? .systemBlue : .orange
        
        if !isFavorited {
            SavedCountryController.favoritedCountries.append(CountryViewController.countriesList[index!])
        }
        else {
            let index = SavedCountryController.favoritedCountries.firstIndex{ $0.name == CountryViewController.countriesList[index!].name }
            if let index = index {
                SavedCountryController.favoritedCountries.remove(at: index)
            }
        }
        
        
        
        //cell.accessoryView?.tintColor = isFavorited ? .systemBlue : .orange

        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

      
        tableView.register(CountCell.self, forCellReuseIdentifier: "CountCell")
        self.tableView.separatorColor = UIColor.clear

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("Num: 1")
        }

    override  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return CountryViewController.countriesList.filter { Country in
//            Country.isFavourite == true
//        }.count
        return SavedCountryController.favoritedCountries.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 65
     }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 40
       }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CountCell", for: indexPath) as! CountCell
            cell.textLabel?.text = SavedCountryController.favoritedCountries[indexPath.row].name
            cell.selectionStyle = .none
            return cell
        }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
        let label = UILabel()
        label.text = "Countries"
        label.textAlignment = .center
        return label
    }
}
