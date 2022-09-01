//
//  RealmDataSource.swift
//  OzeCodingChallenge
//
//  Created by Bakare Waris on 31/08/2022.
//

import Foundation
import RealmSwift

final class RealmDataSource {
    
    init(realm: Realm) {
        realmDB = realm
    }
    
    func realmSaveData(data: [DataRealmModel]) {
        do {
            try realmDB.write({
                realmDB.add(data, update: .all)
            })
        } catch {
            debugPrint(error.localizedDescription)
        }
        
    }
    
    func fetchAllData() -> [DataRealmModel] {
        return Array(realmDB.objects(DataRealmModel.self))
    }
    
    func delete(object: [DataRealmModel]) {
        do {
            try realmDB.write {
                realmDB.delete(object)
                try! realmDB.commitWrite()
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
}
