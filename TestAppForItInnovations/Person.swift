//
//  NetworkService.swift
//  TestAppForItInnovations
//
//  Created by Dima Opalko on 08.01.2020.
//  Copyright © 2020 Dima Opalko. All rights reserved.
//

import Foundation

struct SearchResponce: Codable {
    let persons: [Person]
    private enum CodingKeys: String, CodingKey {
        case persons = "items"
    }
}

struct Person: Codable {
    let firstName: String?
    let lastName: String?
    let plaseOfWork: String?
    let position: String?
    let linkPDF: String?
    
    private enum CodingKeys: String, CodingKey {
        case firstName = "firstname"
        case lastName = "lastname"
        case plaseOfWork = "placeOfWork"
        case position = "position"
        case linkPDF = "linkPDF"
    }
}
