//
//  DataViewModel.swift
//  OzeCodingChallenge
//
//  Created by Bakare Waris on 31/08/2022.
//

import Foundation
import RealmSwift

var counter = 1

class GetDataViewModel {
    
    var baseError: ((String, Int) -> Void)?
    
    var dataSource = RealmDataSource(realm: realmDB)
    
    var dataLists = [DataRealmModel]()
    var completion: (() -> Void)?
    var anotherResult = [DataRealmModel]()
    
    var data:[DataRealmModel]{realmDB.objects(DataRealmModel.self).map({ $0 })}
    
    var usedData = [DataRealmModel]()
    
    func saveDataLists(bills: [DataRealmModel]) {
        dataSource.realmSaveData(data: bills)
    }
    
    func fetchAllCategories() {
        self.dataLists = dataSource.fetchAllData()
    }
    
    func delete(index: [DataRealmModel]) {
//        let selected = data[index]
        dataSource.delete(object: index)
        completion?()
    }
    
    func setUpNetwork() {
        NetworkService.shared.getData{  [weak self ] result in
            switch result {
            case .success(let data):
//                print("data \(data)")
                self?.dataLists = []
                self?.anotherResult = []
                data.items.forEach { obj in
                    let billsObj = DataRealmModel(id:obj.id ,name: obj.login, avatarName: obj.avatarURL)
                    self?.dataLists.append(billsObj)
                }
                
//                debugPrint("--\(self?.dataLists)")
              
                let aValue = "a".unicodeScalars.first!.value
                let zValue = "z".unicodeScalars.first!.value
                for value in aValue...zValue {
                let aChar = Character(UnicodeScalar(value)!)
                    var array = self?.dataLists.filter({ $0.name?.lowercased().first! == aChar
                    }).sorted{$1.name?.caseInsensitiveCompare($0.name ?? "") == .orderedDescending}
                    self?.anotherResult = array ?? [DataRealmModel]()
                   
                    self?.anotherResult.forEach({
                        self?.usedData.append($0)
//                        print("---\(self?.usedData)")
                    })
//                var thisArray = self?.dataLists
//                                .filter{$0.name?.lowercased().first! == aChar}
//                                .sorted{$1.name?.caseInsensitiveCompare($0.name ?? "") == .orderedDescending}
//                    if !(thisArray?.isEmpty ?? false) {
//                        self?.anotherResult = thisArray ?? [DataRealmModel]()
////                        self?.anotherResult.forEach{print("print the dats is \($0)")}
//                    }
//                    self?.anotherResult.forEach{print("print the dats is \($0)")}
                }
                
                debugPrint("iii \(self?.dataLists.count)")
                debugPrint("--- \(self?.usedData.count)")
////                print(self?.dataLists)
////                print(self?.anotherResult)
                
                self?.completion?()
                self?.saveDataLists(bills: self?.dataLists ?? [DataRealmModel]())
            case .failure(let error):
                print("The error is \(error.localizedDescription)")
                
            }
        }
    }
    
}
