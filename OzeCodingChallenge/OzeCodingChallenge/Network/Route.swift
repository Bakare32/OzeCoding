//
//  Route.swift
//  OzeCodingChallenge
//
//  Created by Bakare Waris on 30/08/2022.
//

import Foundation

enum Route {
    static let baseUrl = "https://api.github.com/search/users?"
    
    case pickUpLocation
    
    var description: String {
        switch self {
        case .pickUpLocation:
            return "q=lagos&page=\(counter)"
        }
    }
}
