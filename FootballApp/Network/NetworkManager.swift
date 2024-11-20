//
//  NetworkManager.swift
//  NewsTask
//
//  Created by KhaleD HuSsien on 01/11/2024.
//

import UIKit

class NetworkManager {
    static let shared: NetworkManager = NetworkManager()
    private init() {}
    // MARK: - Functions
    func getData<T: Codable>(urlString: String, headers: [String: String], completion: @escaping (T?, String?) -> Void) {
        // Create URL from string
        guard let url = URL(string: urlString) else {
            completion(nil, "Invalid URL")
            return
        }
        
        // Create URLRequest and add headers
        var request = URLRequest(url: url)
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        // Make network request
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error.localizedDescription)
                return
            }
            
            guard let data = data else {
                completion(nil, "No data received")
                return
            }
            
            do {
                // Decode JSON into CompetitionModel
                let competition = try JSONDecoder().decode(T.self, from: data)
                completion(competition, nil)
            } catch {
                completion(nil, "Decoding error: \(error.localizedDescription)")
            }
        }.resume()
    }
}
