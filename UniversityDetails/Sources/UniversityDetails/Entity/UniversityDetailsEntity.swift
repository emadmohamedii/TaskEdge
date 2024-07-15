//
//  UniversityDetailsEntity.swift
//
//
//  Created by Emad Habib on 15/07/2024.
//

import Foundation

final public class UniversityDetailsEntity {
    let name : String
    let stateProvince : String
    let countryCode: String
    let country: String
    let webPages: [String]
    
    public init(name: String, stateProvince: String, countryCode: String, country: String, webPages: [String]) {
        self.name = name
        self.stateProvince = stateProvince
        self.countryCode = countryCode
        self.country = country
        self.webPages = webPages
    }
}
