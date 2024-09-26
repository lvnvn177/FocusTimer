//
//  Record.swift
//  FocusTimer_version2
//
//  Created by 이영호 on 9/24/24.
//

import Foundation

struct Record: Identifiable, Codable {
    var id = UUID()
    var date: String
    var Time: Int
}
