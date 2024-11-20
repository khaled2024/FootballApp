//
//  MainVC.swift
//  FootballApp
//
//  Created by KhaleD HuSsien on 19/11/2024.
//

import UIKit
import CoreData
class MainVC: UIViewController {
    // MARK: - OUTLETS & VARS
    @IBOutlet weak var heartView: UIView!
    @IBOutlet weak var activityInd: UIActivityIndicatorView!
    @IBOutlet weak var compitionTV: UITableView!
    let vm = MainViewModel()
    
    // MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.compitionTV.separatorStyle = .none
        self.heartView.makeViewCircle()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegatesAndRegisterCell()
        
        if vm.connected(){
            getCompetitions()
        }else{
            AlertRepresenter.showAlert(with: "There is no internet connection!",mess: "You Can Go to Favorite", vc: self) { _ in
                let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FavVC")as! FavVC
                self.navigationController?.pushViewController(VC, animated: true)
            }
        }
    }
    // MARK: - Functions
    func setDelegatesAndRegisterCell(){
        compitionTV.delegate = self
        compitionTV.dataSource = self
        compitionTV.register(UINib(nibName: "CompitionCell", bundle: nil), forCellReuseIdentifier: "CompitionCell")
    }
    func getCompetitions(){
        vm.loading(show: true, indecator: activityInd, tv: compitionTV)
        vm.getCompitions { [weak self] _, error in
            guard let self else { return }
            if let error{
                AlertRepresenter.showAlert(with: "ERROR", mess: error, vc: self, action: { _ in
                })
            }
            DispatchQueue.main.async {
                if self.vm.compitionsArr.isEmpty{
                    AlertRepresenter.showAlert(with: "ERROR", mess: "There is no data", vc: self, action: { _ in
                    })
                }
                self.compitionTV.reloadData()
            }
            vm.loading(show: false, indecator: activityInd, tv: compitionTV)
        }
    }
    @IBAction func favButtonTapped(_ sender: UIButton) {
        let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FavVC")as! FavVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
}
// MARK: - UITableViewDelegate
extension MainVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.compitionsArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompitionCell", for: indexPath)as! CompitionCell
        let model = self.vm.compitionsArr[indexPath.row]
        cell.config(model: model)
        cell.theview.setUpLayerForCell(color: UIColor.gray.cgColor)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CompeDetailsVC")as! CompeDetailsVC
        VC.id = "\(vm.compitionsArr[indexPath.row].id ?? 0)"
        self.navigationController?.pushViewController(VC, animated: true)
    }
}

