//
//  DetailView.swift
//  Countries
//
//  Created by Tuba N. Yıldız on 17.03.2022.
//

import Foundation
import UIKit



class DetailView: UIView{
    
    var country: CountryDetails?{
        didSet{
            priceLabel.text = (country?.code ?? "")
           
            fetchImage(withUrlString: country?.flagImageURI ?? "") { image in
                DispatchQueue.main.async {
                    self.searchImage.image = image
                }
                
            }
        }
        
    }
    var url2 = String()
    
    private lazy var containerView: UIView = {
       let temp = UIView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.clipsToBounds = true
        temp.backgroundColor = .white
        return temp
    }() //boş container, padding vs verirken yönetim kolaylığı sağlar
    
    private lazy var mainStackView: UIStackView = {
    
        let temp = UIStackView(arrangedSubviews: [searchImage, secondStackView])
        searchImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        searchImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.alignment = .center
        temp.distribution = .equalSpacing
        temp.axis = .vertical
        temp.spacing = 0
        return temp
        
        
    }()
    private lazy var secondStackView: UIStackView = {
    
        let temp = UIStackView(arrangedSubviews: [priceLabel, infoButton])
      
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.alignment = .center
        temp.distribution = .fill
        temp.axis = .vertical
        temp.spacing = 0
        return temp
        
        
    }()
   
    private lazy var searchImage: UIImageView = {
        let temp = UIImageView()
        temp.translatesAutoresizingMaskIntoConstraints =  false
        temp.contentMode = .center
        
        //temp.image = UIImage(named: "fav_star")
        return temp
        
    }()
    
    private lazy var priceLabel: UILabel = {
        let temp =  UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
        
    }()
    private lazy var infoButton: UIButton = {
      
        
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
         button.backgroundColor = .systemBlue
        button.setTitle("For More Information", for: .normal)
        button.setImage(UIImage(named: "arrow.png"), for: .normal)
        transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        button.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        button.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        button.addTarget(self, action: #selector(openLink), for: .touchUpInside)

        return button
        
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addUserComponents()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addUserComponents(){

        addSubview(containerView)
        containerView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 60),
            mainStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -300),
            mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
        ])
        
    }
        
    private func setupContainerViewLayers(){
        containerView.layer.cornerRadius = 10
        containerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    @objc private func openLink(){
        guard let id = country?.wikiDataID else {return}
        print("https://www.wikidata.org/wiki/\(id)")
        guard let url = URL(string: "https://www.wikidata.org/wiki/\(id)") else { return }
        UIApplication.shared.open(url)
    }
    
    private func fetchImage(withUrlString urlString: String, completion: @escaping(UIImage)->()){
        
        guard let url  = URL(string: urlString) else {return}
        print(url)
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error =  error {
                print ("fetchin image error", error.localizedDescription)
                return
            }
            
            guard let data  = data  else {return}
            guard let image = UIImage(data: data) else {return}
           
            completion(image)
        }.resume()
    }
    
   
 
}
