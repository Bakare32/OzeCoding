//
//  StringExtension.swift
//  OzeCodingChallenge
//
//  Created by Bakare Waris on 30/08/2022.
//

import Foundation

extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}
