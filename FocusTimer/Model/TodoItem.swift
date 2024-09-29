//
//  TodoItem.swift
//  FocusTimer-version2
//
//  Created by 이영호 on 9/24/24.
//

import Foundation

struct TodoItem: Identifiable, Codable {
    var id = UUID()
    var title: String
    var isActive: Bool = false
}
