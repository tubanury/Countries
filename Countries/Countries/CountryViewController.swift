//
//  CountryTable.swift
//  Countries
//
//  Created by Tuba N. Yıldız on 15.03.2022.
//

import Foundation
import UIKit

class CountryViewController: UITableViewController {
    
    let cellId = "cellId"
    let cellSpacingHeight: CGFloat = 20
    let dvController = DetailViewController()
    static var countriesList = [Country]()

    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Auto-set the UITableViewCells height (requires iOS8+)
        self.tableView.separatorColor = UIColor.clear

        tableView.register(CountryCell.self, forCellReuseIdentifier: cellId)
        NetworkService().fetchCountries { Countries in
            DispatchQueue.main.async {
                for city in  Countries.data{
                    CountryViewController.countriesList.append(Country(isFavourite: false, name: city.name, countryCode: city.code))
                    self.tableView.reloadData()
                }
            }
            
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          
        self.tabBarController?.tabBar.isHidden = true
        dvController.countryCode = CountryViewController.countriesList[indexPath.row].countryCode
        self.navigationController?.pushViewController(dvController, animated: true)

    }

    override  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CountryViewController.countriesList.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 65
     }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return cellSpacingHeight
       }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
           return cellSpacingHeight
       }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CountryCell
            cell.link = self
            let name = CountryViewController.countriesList[indexPath.row].name
            cell.textLabel?.text = name
            cell.selectionStyle = .none
            
            return cell
        }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
        let label = UILabel()
        label.text = "Countries"
        label.textAlignment = .center
        return label
    }
    
    
    //Execute cell star button tapped
    func markAsFavorite(cell: UITableViewCell){
    
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
    }
    
}
