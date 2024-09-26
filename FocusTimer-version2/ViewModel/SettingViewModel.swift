//
//  SettingViewModel.swift
//  iOS-base-app
//
//  Created by 이영호 on 9/22/24.
//

import Foundation

class SettingViewModel: ObservableObject {
    @Published var selectedSound: AlarmSound = .defaultSound
    
    
    let alarmOptions: [AlarmSound] = [
        .sound1, .sound2, .defaultSound, .none
    ]
    
    enum AlarmSound: String, CaseIterable {
        case sound1 = "alarm_water.mp3"
        case sound2 = "alarm_pages.mp3"
        case defaultSound = "기본 알림음"
        case none = "알림음 끄기"
    }
}
