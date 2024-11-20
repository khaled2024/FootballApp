//
//  FavVC.swift
//  FootballApp
//
//  Created by KhaleD HuSsien on 20/11/2024.
//

import UIKit

class FavVC: UIViewController {
    // MARK: - VARS
    @IBOutlet weak var favTV: UITableView!
    let vm = cometetionDetailsViewModel()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMatches()
        setDelegateAndDataSource()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setDesign()
    }
    
    // MARK: - Func
    func setDelegateAndDataSource(){
        favTV.delegate = self
        favTV.dataSource = self
        favTV.register(UINib(nibName: "CompeDetailsCell", bundle: nil), forCellReuseIdentifier: "CompeDetailsCell")
    }
    func setDesign(){
        favTV.separatorStyle = .none
        self.title = "Favourite"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    func fetchMatches(){
        do {
            try vm.matchesOffline =  vm.context.fetch(MatchDataModel.fetchRequest())
            if vm.matchesOffline?.count == 0 {
                AlertRepresenter.showAlert(with: "No Data Cashed", vc: self, action: {_ in})
            }
            DispatchQueue.main.async {
                self.favTV.reloadData()
            }
        } catch  {
            print(error)
        }
    }
}
// MARK: - UITableViewDelegate
extension FavVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm.matchesOffline?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompeDetailsCell", for: indexPath)as! CompeDetailsCell
        cell.favBtn.isHidden = true
        let match = vm.matchesOffline?[indexPath.row]
        if let match{
            cell.configOff(match: match)
            cell.theView.setUpLayerForCell(color: #colorLiteral(red: 0, green: 0.312959075, blue: 0.4944230318, alpha: 1).cgColor)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
