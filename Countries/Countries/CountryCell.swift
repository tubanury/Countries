//
//  CountCell.swift
//  Countries
//
//  Created by Tuba N. Yıldız on 16.03.2022.
//

import Foundation
import UIKit

class CountryCell: UITableViewCell{
    
    var link: CountryViewController?
    var linkSaved: SavedCountryController?
    
    
    //Border of cell
    lazy var backView: UIView = {

        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViewConfigurations()
    }
  
    @objc func handleMarkAsFavourite(){
        print("mark as fav")
        link?.markAsFavorite(cell: self)
        linkSaved?.markFavorite(cell: self)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureViewConfigurations(){
       
        let star = UIButton()
        star.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        let image = UIImage(#imageLiteral(resourceName: "fav_star_filled_2")).withRenderingMode(.alwaysTemplate)
        star.setImage(image, for: .normal)
        star.addTarget(self, action: #selector(handleMarkAsFavourite), for: .touchUpInside)
        
        accessoryView = star
        
        addSubview(backView)
        backView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: -10, paddingRight: -10, width: 0, height: 15)
    }

}
