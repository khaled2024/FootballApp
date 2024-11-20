//
//  CompetetionDetailsModel.swift
//  FootballApp
//
//  Created by KhaleD HuSsien on 20/11/2024.
//

import Foundation

// MARK: - CompetetionDetailsModel
struct CompetetionDetailsModel: Codable {
    let filters: Filters?
    let resultSet: ResultSet?
    let competition: CompetitionDetails?
    let matches: [Match]?
}

// MARK: - Competition
struct CompetitionDetails: Codable {
    let id: Int?
    let name: String?
    let code: String?
    let type: String?
    let emblem: String?
}

// MARK: - Match
struct Match: Codable {
    let area: Area?
    let competition: Competition?
    let season: Season?
    let id: Int?
    let utcDate: String?
    let status: String?
    let matchday: Int?
    let stage: String?
    let lastUpdated: String?
    let homeTeam, awayTeam: Team?
    let score: Score?
    let referees: [Referee]?
}

enum AreaCode: String, Codable {
    case eng = "ENG"
}

enum NationalityEnum: String, Codable {
    case england = "England"
}

// MARK: - Team
struct Team: Codable {
    let id: Int?
    let name: String?
    let shortName: String?
    let tla: String?
    let crest: String?
}


// MARK: - Odds
struct Odds: Codable {
    let msg: Msg?
}

enum Msg: String, Codable {
    case activateOddsPackageInUserPanelToRetrieveOdds = "Activate Odds-Package in User-Panel to retrieve odds."
}

// MARK: - Referee
struct Referee: Codable {
    let id: Int?
    let name: String?
    let type: String?
    let nationality: String?
}

enum RefereeType: String, Codable {
    case referee = "REFEREE"
}

// MARK: - Score
struct Score: Codable {
    let winner: String?
    let duration: String?
    let fullTime, halfTime: Time?
}

// MARK: - Time
struct Time: Codable {
    let home, away: Int?
}

// MARK: - Season
struct Season: Codable {
    let id: Int?
    let startDate, endDate: String?
    let currentMatchday: Int?
}

enum Stage: String, Codable {
    case regularSeason = "REGULAR_SEASON"
}


// MARK: - ResultSet
struct ResultSet: Codable {
    let count: Int?
    let first, last: String?
    let played: Int?
}
