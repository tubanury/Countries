//
//  SavedCountryController.swift
//  Countries
//
//  Created by Tuba N. Yıldız on 16.03.2022.




import Foundation
import UIKit

class SavedCountryController: UITableViewController {

    let cellSpacingHeight: CGFloat = 20
    static var favoritedCountries = [Country]()
    let detailView = DetailViewController()
    
    
    func markFavorite(cell: UITableViewCell){
        
        let indexClicked = tableView.indexPath(for: cell)
        let index = indexClicked?.row
        let isFavorited = CountryViewController.countriesList[index!].isFavourite
        CountryViewController.countriesList[index!].isFavourite = !isFavorited
        cell.accessoryView?.tintColor = .orange
        
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
    override func viewDidLoad() {
        super.viewDidLoad()

      
        tableView.register(CountryCell.self, forCellReuseIdentifier: "CountCell")
        self.tableView.separatorColor = UIColor.clear

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        self.tabBarController?.tabBar.isHidden = false
       
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.tabBarController?.tabBar.isHidden = true
        detailView.countryCode = SavedCountryController.favoritedCountries[indexPath.row].countryCode
        self.navigationController?.pushViewController(detailView, animated: true)
    }

    override  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SavedCountryController.favoritedCountries.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 65
     }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 40
       }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CountCell", for: indexPath) as! CountryCell
            cell.textLabel?.text = SavedCountryController.favoritedCountries[indexPath.row].name
            cell.selectionStyle = .none
            cell.accessoryView?.tintColor = .orange
            return cell
        }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
        let label = UILabel()
        label.text = "Countries"
        label.textAlignment = .center
        return label
    }
}
