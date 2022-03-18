//
//  CountryCell.swift
//  Countries
//
//  Created by Tuba N. Yıldız on 15.03.2022.
//

import Foundation
import UIKit



class CountryCell: UITableViewCell {
    
    
    private lazy var containerView: UIView = {
           let view = UIView()
           view.translatesAutoresizingMaskIntoConstraints = false
           view.layer.cornerRadius = 2
           view.clipsToBounds = true

            view.addSubview(view2)
           //view.backgroundColor = .systemPink
           //view.addSubview(nameLabel)
           //nameLabel.center(inView: view)
           //nameLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        view2.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 12, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 30, height: 20)
           return view
       }()
    private lazy var view2: UIView = {
           let view = UIView()
           view.translatesAutoresizingMaskIntoConstraints = false
           view.layer.cornerRadius = 2
           view.clipsToBounds = true

           //view.backgroundColor = .systemPink
           view.addSubview(nameLabel)
           //nameLabel.center(inView: view)
           nameLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
          
           return view
       }()
    
    let nameLabel: UILabel = {
           let temp = UILabel()
            temp.textColor = .black
            //temp.font = UIFont.systemFont(ofSize: 16)
            temp.text = "Germany"
           
            temp.textAlignment = .center
            
            return temp
        }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViewConfigurations()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureViewConfigurations(){
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        let iv = UIButton()
        iv.setTitleColor(.purple, for: .normal)
        iv.setImage(UIImage(named: "fav_star.png"), for: .normal)
        iv.frame = CGRect(x: 0, y:0, width: 15, height:15)
        
        addSubview(containerView)
        containerView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 48)

        containerView.addSubview(iv)
    }
    
    
}
