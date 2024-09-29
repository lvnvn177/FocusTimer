//
//  Setting.swift
//  FocusTimer-version2
//
//  Created by 이영호 on 9/27/24.
//

import Foundation

struct Setting: Identifiable, Codable {
    var id = UUID()
    var Alarm: String
    var Back: String
}
