//
//  NetworkService.swift
//  TestAppForItInnovations
//
//  Created by Dima Opalko on 08.01.2020.
//  Copyright © 2020 Dima Opalko. All rights reserved.
//

import Foundation

class NetworkService {
    
    func fetchPersons(searchText: String, completion: @escaping (SearchResponce?) -> Void) {
        let url = "https://public-api.nazk.gov.ua/v1/declaration/?q=\(searchText)".encodeUrl.lowercased()
        print(url)
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { ( data, responce, error) in
                if let data = data {
                    do {
                        let personsList = try JSONDecoder().decode(SearchResponce.self, from: data)
                        completion(personsList)
                        print(personsList)
                    } catch {
                        completion(nil)
                        print(error)
                    }
                }
                else {
                    completion(nil)
                }
            }.resume()
        }
    }
}

extension String {
    var encodeUrl : String {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
}
