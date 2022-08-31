//
//  DataViewModel.swift
//  OzeCodingChallenge
//
//  Created by Bakare Waris on 31/08/2022.
//

import Foundation


class GetDataViewModel {
    
    func setUpNetwork() {
        NetworkService.shared.getData{  [weak self ] result in
            switch result {
            case .success(let data):
                print("data \(data)")
//                self?.items.append(contentsOf: data.photos.photo)
//                self?.completion?()
            case .failure(let error):
                print("The error is \(error.localizedDescription)")
            }
        }
    }
}
