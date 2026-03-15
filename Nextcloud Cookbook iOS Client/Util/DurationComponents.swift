//
//  Duration.swift
//  Nextcloud Cookbook iOS Client
//
//  Created by Vincent Meilinger on 11.11.23.
//

import Foundation
import SwiftUI


class DurationComponents: ObservableObject {
    @Published var secondComponent: Int = 0 {
        didSet {
            if secondComponent > 59 {
                secondComponent = 59
            } else if secondComponent < 0 {
                secondComponent = 0
            }
        }
    }
    @Published var minuteComponent: Int = 0 {
        didSet {
            if minuteComponent > 59 {
                minuteComponent = 59
            } else if minuteComponent < 0 {
                minuteComponent = 0
            }
        }
    }
    
    @Published var hourComponent: Int = 0 {
        didSet {
            if hourComponent < 0 {
                hourComponent = 0
            }
        }
    }
    
    
    
    var displayString: String {
        if hourComponent != 0 && minuteComponent != 0 {
            return "\(hourComponent) h \(minuteComponent) min"
        } else if hourComponent == 0 && minuteComponent != 0 {
            return "\(minuteComponent) min"
        } else if hourComponent != 0 && minuteComponent == 0 {
            return "\(hourComponent) h"
        } else {
            return "-"
        }
    }
    
    static func fromPTString(_ PTRepresentation: String) -> DurationComponents {
        let duration = DurationComponents()
        duration.fromPTString(PTRepresentation)
        return duration
    }
    
    func fromPTString(_ PTRepresentation: String) {
        let hourRegex = /([0-9]{1,2})H/
        let minuteRegex = /([0-9]{1,2})M/
        let secondRegex = /([0-9]{1,2})S/
        if let match = PTRepresentation.firstMatch(of: hourRegex) {
            self.hourComponent = Int(match.1) ?? 0
        }
        if let match = PTRepresentation.firstMatch(of: minuteRegex) {
            self.minuteComponent = Int(match.1) ?? 0
        }
        if let match = PTRepresentation.firstMatch(of: secondRegex) {
            self.secondComponent = Int(match.1) ?? 0
        }
    }
    
    private func stringFormatComponents() -> (String, String, String) {
        let sec = secondComponent < 10 ? "0\(secondComponent)" : "\(secondComponent)"
        let min = minuteComponent < 10 ? "0\(minuteComponent)" : "\(minuteComponent)"
        let hr = hourComponent < 10 ? "0\(hourComponent)" : "\(hourComponent)"
        return (hr, min, sec)
    }
    
    func toPTString() -> String {
        let (hr, min, sec) = stringFormatComponents()
        return "PT\(hr)H\(min)M\(sec)S"
    }
    
    func toTimerText() -> String {
        var timeString = ""
        let (hr, min, sec) = stringFormatComponents()
        if hourComponent != 0 {
            timeString.append("\(hr):")
        }
        timeString.append("\(min):")
        timeString.append(sec)
        return timeString
    }
    
    func toSeconds() -> Double {
        return Double(hourComponent) * 3600 + Double(minuteComponent) * 60 + Double(secondComponent)
    }
    
    func fromSeconds(_ totalSeconds: Int) {
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        self.hourComponent = Int(hours)
        self.minuteComponent = Int(minutes)
        self.secondComponent = Int(seconds)
    }
    
    static func ptToText(_ ptString: String) -> String? {
        let duration = DurationComponents.fromPTString(ptString)

        if duration.hourComponent != 0 && duration.minuteComponent != 0 {
            return "\(duration.hourComponent) h, \(duration.minuteComponent) min"
        } else if duration.hourComponent == 0 && duration.minuteComponent != 0 {
            return duration.secondComponent == 0 ? "\(duration.minuteComponent) min" : "\(duration.minuteComponent) min, \(duration.secondComponent) sec"
        } else if duration.hourComponent != 0 && duration.minuteComponent == 0 {
            return duration.secondComponent == 0 ? "\(duration.hourComponent) h" : "\(duration.hourComponent) h, \(duration.secondComponent) sec"
        } else if duration.secondComponent != 0 {
            return "\(duration.secondComponent) sec"
        } else {
            return nil
        }
    }
    
    static func + (lhs: DurationComponents, rhs: DurationComponents) -> DurationComponents {
        let totalSeconds = lhs.toSeconds() + rhs.toSeconds()
        let result = DurationComponents()
        result.fromSeconds(Int(totalSeconds))
        return result
    }
}
