//
//  CometetionDetailsViewModel.swift
//  FootballApp
//
//  Created by KhaleD HuSsien on 20/11/2024.
//

import UIKit
class cometetionDetailsViewModel{
    var cometetionDetails:CompetetionDetailsModel?
    var matchesOffline: [MatchDataModel]?
    let monitor = NetworkMonitor.shared
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getAllCompetetionDetails(with id: String,completion: @escaping (()?,String?) -> Void){
        let headers = [
            "X-Auth-Token":Constant.API_KEY,
            "Content-Type": "application/json"
        ]
        print(Constant.URL + "competitions/" + "\(id)" + "/matches")
        NetworkManager.shared.getData(urlString: Constant.URL + "competitions/" + "\(id)" + "/matches", headers: headers) { (details:CompetetionDetailsModel?, err) in
            if let err = err{
                completion(nil,err)
            }else if let details = details{
                self.cometetionDetails = details
                completion((), nil)
            }
        }
    }
    func loading(show: Bool,indecator: UIActivityIndicatorView,tv: UITableView){
        DispatchQueue.main.async {
            if show{
                indecator.isHidden = false
                indecator.startAnimating()
                tv.isHidden = true
            }else{
                indecator.isHidden = true
                indecator.stopAnimating()
                tv.isHidden = false
            }
        }
    }
    func delete(model: MatchDataModel){
        self.context.delete(model)
        do {
            try context.save()
        } catch  {
            print(error)
        }
    }
    func createMatch(model: Match){
        let match = MatchDataModel(context: context)
        match.homeImage = model.homeTeam?.crest
        match.homeName = model.homeTeam?.name
        match.homeCode = model.homeTeam?.tla
        match.status = model.status
        match.homeResult = "\(model.score?.fullTime?.home ?? 0)"
        
        match.awayImage = model.awayTeam?.crest
        match.awayName = model.awayTeam?.name
        match.awayCode = model.homeTeam?.tla
        match.awayResult = "\(model.score?.fullTime?.away ?? 0)"
        do {
            try context.save()
        } catch  {
            print(error)
        }
    }
}
