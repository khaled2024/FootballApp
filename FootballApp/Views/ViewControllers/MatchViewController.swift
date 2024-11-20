//
//  MatchViewController.swift
//  FootballApp
//
//  Created by KhaleD HuSsien on 20/11/2024.
//

import UIKit

class MatchViewController: UIViewController {
    // MARK: - VARS & Outlets
    var id: String! = ""
    let vm = MatchViewModel()
    
    @IBOutlet weak var refereeNatipnalityStackView: UIStackView!
    @IBOutlet weak var refereeNameStack: UIStackView!
    @IBOutlet weak var dateMAtche: UILabel!
    @IBOutlet weak var fullTime: UILabel!
    @IBOutlet weak var halfTimeLabel: UILabel!
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var refereeNat: UILabel!
    @IBOutlet weak var refereeName: UILabel!
    @IBOutlet weak var stageLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var countryNameCode: UILabel!
    @IBOutlet weak var matchInfoLabel: UILabel!
    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var leagueCode: UILabel!
    @IBOutlet weak var awayTeamImage: UIImageView!
    @IBOutlet weak var theView: UIView!
    @IBOutlet weak var awayTeamCode: UILabel!
    @IBOutlet weak var awayTeamName: UILabel!
    @IBOutlet weak var matchStatus: UILabel!
    @IBOutlet weak var homeTeamCode: UILabel!
    @IBOutlet weak var homeTeamName: UILabel!
    @IBOutlet weak var homeTeamImage: UIImageView!
    @IBOutlet weak var awayTeamResult: UILabel!
    @IBOutlet weak var homeAwayResult: UILabel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getMatchInfo()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    // MARK: - Func
    func getMatchInfo(){
        vm.getAllMatchInfo(with: id) { [weak self] _, error in
            guard let self else { return }
            if let error = error{
                DispatchQueue.main.async(execute: {
                    AlertRepresenter.showAlert(with: error, vc: self, action: {_ in})
                })
            }
            else if let matcheInfo = self.vm.match{
                DispatchQueue.main.async(execute: {
                    self.leagueImage.loadDataUsingCacheWithUrlString(urlString: matcheInfo.competition?.emblem ?? "")
                    self.leagueName.text = matcheInfo.competition?.name ?? ""
                    self.leagueCode.text = "( \(matcheInfo.competition?.code ?? "") )"
                    self.config(match: matcheInfo)
                })
            }
        }
    }
    func config(match: Match){
        
        self.homeTeamImage.loadDataUsingCacheWithUrlString(urlString: match.homeTeam?.crest ?? "")
        self.awayTeamImage.loadDataUsingCacheWithUrlString(urlString: match.awayTeam?.crest ?? "")
        self.homeTeamName.text = match.homeTeam?.name ?? ""
        self.awayTeamName.text = match.awayTeam?.name ?? ""
        self.homeTeamCode.text = "( \(match.homeTeam?.tla ?? "") )"
        self.awayTeamCode.text = "( \(match.awayTeam?.tla ?? "") )"
        
        self.homeAwayResult.text = "\(match.score?.fullTime?.home ?? 0)"
        self.awayTeamResult.text = "\(match.score?.fullTime?.away ?? 0)"
        
        self.matchStatus.text = match.status?.capitalized
        
        self.countryNameCode.text = "\(match.area?.name ?? "") - (\(match.area?.code ?? ""))"
        self.statusLabel.text = match.status ?? ""
        self.stageLabel.text = match.stage ?? ""
        if match.referees?.count == 0 {
            refereeNameStack.isHidden = true
            refereeNatipnalityStackView.isHidden = true
        }
        self.refereeName.text = match.referees?.first?.name ?? ""
        self.refereeNat.text = match.referees?.first?.nationality ?? "-----"
        if match.score?.winner == "AWAY_TEAM"{
            self.winnerLabel.text = match.awayTeam?.name ?? ""
        }else if match.score?.winner == "HOME_TEAM"{
            self.winnerLabel.text = match.homeTeam?.name ?? ""
        }
        halfTimeLabel.text = "\(match.homeTeam?.shortName ?? "") \(match.score?.halfTime?.home ?? 0) - \(match.awayTeam?.shortName ?? "") \(match.score?.halfTime?.away ?? 0)"
        
        fullTime.text = "\(match.homeTeam?.shortName ?? "") \(match.score?.fullTime?.home ?? 0) - \(match.awayTeam?.shortName ?? "") \(match.score?.fullTime?.away ?? 0)"
        let inputDate = match.utcDate ?? ""
        let inputFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let outputFormat = "MMM dd, yyyy hh:mm a"
        self.dateMAtche.text = self.formatDateString(input: inputDate, inputFormat: inputFormat, outputFormat: outputFormat)
    }
}

