//
//  extesnion+uiviewcontroller.swift
//  FootballApp
//
//  Created by KhaleD HuSsien on 20/11/2024.
//

import UIKit
extension UIViewController {
    func formatDateString(input: String, inputFormat: String, outputFormat: String) -> String? {
        // Step 1: Create a DateFormatter for the input string
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputFormat
        inputFormatter.locale = Locale(identifier: "en_US_POSIX") // Ensure consistent parsing

        // Convert input string to Date
        guard let date = inputFormatter.date(from: input) else {
            print("Invalid input date string")
            return nil
        }

        // Step 2: Create a DateFormatter for the output string
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = outputFormat
        outputFormatter.locale = Locale(identifier: "en_US_POSIX") // Ensure consistent output

        // Convert Date to output string
        return outputFormatter.string(from: date)
    }

}
