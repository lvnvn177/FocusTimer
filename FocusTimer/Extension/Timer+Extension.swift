//
//  Timer+Extension.swift
//  FocusTimer-version2
//
//  Created by 이영호 on 9/24/24.
//

import Foundation
import AVFoundation

extension Int {
    var timeString: String {
        let hours = self / 3600
        let minutes = (self % 3600) / 60
        let seconds = self % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
