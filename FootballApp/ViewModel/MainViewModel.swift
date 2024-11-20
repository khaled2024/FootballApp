//
//  MainViewModel.swift
//  FootballApp
//
//  Created by KhaleD HuSsien on 19/11/2024.
//

import UIKit
class MainViewModel{
    var compitionsArr: [Competition] = []
    
    var compitionsArrOffline: [CompetitionDataModel] = []
    let monitor = NetworkMonitor.shared

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    func getCompitions(completion: @escaping ((),String?) -> Void) {
        let headers = [
            "X-Auth-Token":Constant.API_KEY,
            "Content-Type": "application/json"
        ]
        NetworkManager.shared.getData(urlString: "\(Constant.URL)competitions", headers: headers) {(competetionModel: CompetitionModel? ,error ) in
            if let error = error{
                print("error \(error)")
                completion((),error)
            }else if let competetionModel{
                self.compitionsArr = competetionModel.competitions ?? []
                completion((), nil)
            }
        }
        
    }
    func connected()-> Bool{
        if monitor.isConnected {
            return true
        } else {
            return false
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
}

