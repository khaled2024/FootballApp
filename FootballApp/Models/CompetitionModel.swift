//
//  CompetitionModel.swift
//  FootballApp
//
//  Created by KhaleD HuSsien on 19/11/2024.
//

import Foundation

// MARK: - CompetitionModel
struct CompetitionModel: Codable {
    let count: Int?
    let filters: Filters?
    let competitions: [Competition]?
}

// MARK: - Competition
struct Competition: Codable {
    let id: Int?
    let area: Area?
    let name, code: String?
    let type: String?
    let emblem: String?
    let plan: String?
    let currentSeason: CurrentSeason?
    let numberOfAvailableSeasons: Int?
    let lastUpdated: String?
}

// MARK: - Area
struct Area: Codable {
    let id: Int?
    let name, code: String?
    let flag: String?
}

// MARK: - CurrentSeason
struct CurrentSeason: Codable {
    let id: Int?
    let startDate, endDate: String?
    let currentMatchday: Int?
}



// MARK: - Filters
struct Filters: Codable {
    let client: String?
    let season: String?
}
