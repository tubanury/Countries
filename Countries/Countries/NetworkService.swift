//
//  NetworkService.swift
//  Countries
//
//  Created by Tuba N. Yıldız on 17.03.2022.
//

import Foundation
import UIKit

struct Countries: Codable {
  let data: [CountryResult]
}
struct CountryDetail: Codable {
  let data: CountryDetails
  
}

struct CountryResult: Codable, Identifiable, Hashable {
  let code: String
  let name: String
  var id: String { code }
  
  enum CodingKeys: String, CodingKey {
    case code, name
  }
}


struct CountryDetails: Codable {
  let name: String
  let code: String
  let flagImageURI: String
  let wikiDataID: String

    enum CodingKeys: String, CodingKey {
    case wikiDataID = "wikiDataId"
    case flagImageURI = "flagImageUri"
    case name, code
  }
}


class NetworkService: ObservableObject {
  
    
  func fetchCountries(completion:@escaping (Countries) -> ()) {
      let headers = [
          "x-rapidapi-host": "wft-geo-db.p.rapidapi.com",
          "x-rapidapi-key": "cdf8a5d879mshbca1b8b8762bc37p1fb308jsn55f11d3ea066"
      ]

      let request = NSMutableURLRequest(url: NSURL(string: "https://wft-geo-db.p.rapidapi.com/v1/geo/countries?limit=10")! as URL,
                                              cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
    
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
    
    URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error)  in
      do {
        if let data = data {
          let result = try JSONDecoder().decode(Countries.self, from: data)
            print(result)
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            completion(result)
          }
        } else {
          print("No data")
        }
      }
      catch(let error) {
        debugPrint(error)
      }
    }).resume()
  }
    
    
    
    
    
    func fetchCountryDetails(countryCode: String, completion:@escaping (CountryDetail) -> ()) {
      let headers = [
        "x-rapidapi-host": "wft-geo-db.p.rapidapi.com",
        "x-rapidapi-key": "cdf8a5d879mshbca1b8b8762bc37p1fb308jsn55f11d3ea066"
      ]
      
      let request = NSMutableURLRequest(url: NSURL(string: "https://wft-geo-db.p.rapidapi.com/v1/geo/countries/\(countryCode)")! as URL,
                                        cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
      request.httpMethod = "GET"
      request.allHTTPHeaderFields = headers
      
      
      URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error)  in
        do {
          if let data = data {
            let result = try JSONDecoder().decode(CountryDetail.self, from: data)
            DispatchQueue.main.async {
              completion(result)
            }
          } else {
            print("No data")
          }
        }
        catch(let error) {
          debugPrint(error)
        }
      }).resume()
    }
    
    
//    private func fetchImage(withUrlString urlString: String, completion: @escaping(UIImage)->()){
//
//        guard let url  = URL(string: urlString) else {return}
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error =  error {
//                print ("fetchin image error", error.localizedDescription)
//                return
//            }
//
//            guard let data  = data  else {return}
//            guard let image = UIImage(data: data) else {return}
//
//            completion(image)
//        }.resume()
}
