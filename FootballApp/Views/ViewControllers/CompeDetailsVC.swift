//
//  CompeDetailsVC.swift
//  FootballApp
//
//  Created by KhaleD HuSsien on 20/11/2024.
//

import UIKit

class CompeDetailsVC: UIViewController {
    // MARK: - VARS & Outlets
    @IBOutlet weak var competetionDetailsTV: UITableView!
    @IBOutlet weak var leagueCode: UILabel!
    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var activityInd: UIActivityIndicatorView!
    let vm = cometetionDetailsViewModel()
    var id: String! = ""
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegatesAndRegisterCell()
        getCometeDetails()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setDesign()
    }
    // MARK: - functions
    func setDesign(){
        self.view.backgroundColor = .white
        competetionDetailsTV.separatorStyle = .none
        self.leagueImage.contentMode = .scaleAspectFill
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    func setDelegatesAndRegisterCell(){
        competetionDetailsTV.delegate = self
        competetionDetailsTV.dataSource = self
        competetionDetailsTV.register(UINib(nibName: "CompeDetailsCell", bundle: nil), forCellReuseIdentifier: "CompeDetailsCell")
    }
    func getCometeDetails() {
        vm.loading(show: true, indecator: self.activityInd, tv: competetionDetailsTV)
        vm.getAllCompetetionDetails(with: id,completion: { [weak self] _, err in
            guard let self else { return }
            if let err = err{
                DispatchQueue.main.async(execute: {
                    AlertRepresenter.showAlert(with: err, vc: self, action: {_ in})
                })
            }
            else if let competetionModel = self.vm.cometetionDetails{
                setData(competetion: competetionModel)
                DispatchQueue.main.async {
                    self.competetionDetailsTV.reloadData()
                }
            }
            vm.loading(show: false, indecator: self.activityInd, tv: competetionDetailsTV)
        })
    }
    func setData(competetion: CompetetionDetailsModel){
        DispatchQueue.main.async {
            self.leagueImage.loadDataUsingCacheWithUrlString(urlString: competetion.competition?.emblem ?? "")
            self.leagueName.text = competetion.competition?.name
            self.leagueCode.text = "( \(competetion.competition?.code ?? "") )"
        }
    }
}
// MARK: - UITableViewDelegate
extension CompeDetailsVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm.cometetionDetails?.matches?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompeDetailsCell", for: indexPath) as! CompeDetailsCell
        let match = vm.cometetionDetails?.matches?[indexPath.row]
        cell.theView.setUpLayerForCell(color: #colorLiteral(red: 0, green: 0.312959075, blue: 0.4944230318, alpha: 1).cgColor)
        cell.tapped = {
            if cell.favBtn.imageView?.image == UIImage(systemName: "heart"){
                cell.favBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                if let match{
                    self.vm.createMatch(model: match)
                }
            }else{
                cell.favBtn.setImage(UIImage(systemName: "heart"), for: .normal)
            }
        }
        if let match{
            cell.config(match: match)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MatchViewController")as! MatchViewController
        let match = vm.cometetionDetails?.matches?[indexPath.row]
        VC.id = "\(match?.id ?? 0)"
        self.navigationController?.pushViewController(VC, animated: true)
    }
}
