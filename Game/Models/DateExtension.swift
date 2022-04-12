//
//  DateExtension.swift
//  ActivityChallenge
//
//  Created by Amer  on 03/06/22.
//

import Foundation

extension Date {
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: self)
    }
}
