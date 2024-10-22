//
//  Date+Utils.swift
//  RickAndMortyApp
//
//  Created by Pablo Alonso Gonzalez on 20/10/24.
//
import Foundation

extension Date {
    var toString: String {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("dd MMMM yyyy")
        return formatter.string(from: self)
    }
}

extension String {
    func toDate() throws -> Date {
        if let date = DateFormatter.createdDateFormatter.date(from: self) {
            return date
        }
        if let date = DateFormatter.airDateDateFormatter.date(from: self) {
            return date
        }
        throw MapError.invalidData
    }
}

extension DateFormatter {
    static var createdDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }
    
    static var airDateDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }
}
