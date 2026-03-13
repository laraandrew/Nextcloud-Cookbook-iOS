//
//  DateExtension.swift
//  Nextcloud Cookbook iOS Client
//
//  Created by Vincent Meilinger on 14.12.23.
//

import Foundation

extension Date {
    private static func localFormatter(withFormat format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone.current
        return formatter
    }

    static func convertUTCStringToLocalString(utcDateString: String, withFormat format: String = "yyyy-MM-dd HH:mm:ss") -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = format
        inputFormatter.timeZone = TimeZone(secondsFromGMT: 0)

        guard let date = inputFormatter.date(from: utcDateString) else {
            return nil
        }
        return localFormatter(withFormat: format).string(from: date)
    }

    static func convertISOStringToLocalString(isoDateString: String, withFormat format: String = "yyyy-MM-dd HH:mm:ss") -> String? {
        let inputFormatter = ISO8601DateFormatter()
        guard let date = inputFormatter.date(from: isoDateString) else {
            return nil
        }
        return localFormatter(withFormat: format).string(from: date)
    }
}
