//
//  Collection.swift
//  HepsiBurada_MobileTeamCaseStudy
//
//  Created by Mac on 29.10.2021.
//

import Foundation
struct Collection: Codable {
    var resultCount: Int
    var results: [Result]
}
struct Result: Codable {
    let artworkUrl100: String
    let collectionPrice: Double
    let collectionName: String?
    let releaseDate: String
    let wrapperType: String
}

