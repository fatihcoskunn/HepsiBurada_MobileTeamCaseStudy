//
//  WebService.swift
//  HepsiBurada_MobileTeamCaseStudy
//
//  Created by Mac on 29.10.2021.
//

import Foundation

class WebService {
    
    func collectionApi(url: URL, completion: @escaping (Collection?) -> ()){
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
               let collection = try? JSONDecoder().decode(Collection.self, from: data)
                if let collection = collection {
                    completion(collection)
                }
            }
        }.resume()
    }
}
