//
//  AppUtils.swift
//ActivityChallenge

import Foundation

struct AppUtils {

    private static let userDefaults = UserDefaults.standard
    static private let kStartDate = "start_date"

    static func getFormattedDate(_ date: Date?) -> String {
        guard let date = date else {
            return ""
        }
        return date.formattedDate
    }

    static func saveStartDate(_ date: Date) {
        userDefaults.set(date, forKey: kStartDate)
    }

    static func getStartDate() -> Date? {
        return userDefaults.object(forKey: kStartDate) as? Date
    }

    static func clearUserData() {
        userDefaults.removeObject(forKey: kStartDate)
    }
}
