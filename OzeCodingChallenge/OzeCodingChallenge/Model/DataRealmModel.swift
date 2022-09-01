//
//  DataRealmModel.swift
//  OzeCodingChallenge
//
//  Created by Bakare Waris on 31/08/2022.
//

import Foundation
import RealmSwift

class DataRealmModel: Object {
    
    @Persisted(primaryKey: true) var id: Int?
    @Persisted var name: String?
    @Persisted var avatarName: String?
    convenience init(id: Int? = 0,
             name: String? = "",
                     avatarName: String? = "") {
        self.init()
        self.id = id
        self.name = name
        self.avatarName = avatarName
    }
}
