//
//  CompitionCell.swift
//  FootballApp
//
//  Created by KhaleD HuSsien on 19/11/2024.
//

import UIKit

class CompitionCell: UITableViewCell {
    @IBOutlet weak var theview: UIView!
    
    @IBOutlet weak var currentMatchDay: UILabel!
    @IBOutlet weak var numOfSeason: UILabel!
    @IBOutlet weak var leagueCode: UILabel!
    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var leagueImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func config(model: Competition){
        if let code = model.code {
            self.leagueCode.text = "(\(code))"
        }else{
            self.leagueCode.text = ""
        }
        self.leagueName.text = model.name ?? ""
        self.numOfSeason.text =  "Number of Available Seasons :- \(model.numberOfAvailableSeasons ?? 0)"
        self.currentMatchDay.text = "Current Match day :- \(model.currentSeason?.currentMatchday ?? 0 )"
        self.leagueImage.loadDataUsingCacheWithUrlString(urlString: model.emblem ?? "")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        leagueImage.image = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
