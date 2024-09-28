//
//  TimerAttributes.swift
//  FocusTimer-version2
//
//  Created by 이영호 on 9/29/24.
//

import Foundation
import ActivityKit

struct TimerAttributes: ActivityAttributes {
    
    public typealias TimeTrackingStatus = ContentState
    
    public struct ContentState: Codable, Hashable {
        var remainingTime: TimeInterval
        var timer: ClosedRange<Date>
    }

    var totalTime: TimeInterval
    var name: String
}
