//
//  CompeDetailsCell.swift
//  FootballApp
//
//  Created by KhaleD HuSsien on 20/11/2024.
//

import UIKit

class CompeDetailsCell: UITableViewCell {
    @IBOutlet weak var awayTeamImage: UIImageView!
    
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var theView: UIView!
    @IBOutlet weak var awayTeamCode: UILabel!
    @IBOutlet weak var awayTeamName: UILabel!
    @IBOutlet weak var matchStatus: UILabel!
    @IBOutlet weak var homeTeamCode: UILabel!
    @IBOutlet weak var homeTeamName: UILabel!
    @IBOutlet weak var homeTeamImage: UIImageView!
    
    @IBOutlet weak var awayTeamResult: UILabel!
    
    @IBOutlet weak var homeAwayResult: UILabel!
    
    var tapped: (()-> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
    }
    func configOff(match: MatchDataModel){
        
        self.homeTeamImage.loadDataUsingCacheWithUrlString(urlString: match.homeImage ?? "")
        self.awayTeamImage.loadDataUsingCacheWithUrlString(urlString: match.awayImage ?? "")
        self.homeTeamName.text = match.homeName ?? ""
        self.awayTeamName.text = match.awayName ?? ""
        self.homeTeamCode.text = "( \(match.homeCode ?? "") )"
        self.awayTeamCode.text = "( \(match.awayCode ?? "") )"
        
        self.homeAwayResult.text = "\(match.homeResult ?? "")"
        self.awayTeamResult.text = "\(match.awayResult ?? "")"
        
        self.matchStatus.text = match.status?.capitalized
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBAction func favTapped(_ sender: UIButton) {
        self.tapped?()
    }
    
}
