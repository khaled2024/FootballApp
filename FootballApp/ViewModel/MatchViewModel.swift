//
//  MatchViewModel.swift
//  FootballApp
//
//  Created by KhaleD HuSsien on 20/11/2024.
//

import Foundation
class MatchViewModel{
    var match: Match?
    
    func getAllMatchInfo(with id: String,completion: @escaping (()?,String?) -> Void){
        let headers = [
            "X-Auth-Token":Constant.API_KEY,
            "Content-Type": "application/json"
        ]
        print(Constant.URL + "matches/" + "\(id)")
        NetworkManager.shared.getData(urlString: Constant.URL + "matches/" + "\(id)", headers: headers) { (matchInfo:Match?, err) in
            if let err = err{
                completion(nil,err)
            }else if let matchInfo = matchInfo{
                self.match = matchInfo
                completion((), nil)
            }
        }
    }

    
}
