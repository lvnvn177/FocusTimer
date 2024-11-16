//
//  SettingViewModel.swift
//  iOS-base-app
//
//  Created by 이영호 on 9/22/24.
//

import Foundation
import DataManager

class SettingViewModel: ObservableObject {
    
    let SettingDataManager = DataManager<Setting>()
    
    @Published var set: Setting = Setting(Alarm: ".defaultSound", Back: ".none") {
        didSet {
            SettingDataManager.saveSetting(set, forKey: "Setting")
        }
    }
    
    
    init() {
        
        self.set = SettingDataManager.loadSetting(forKey: "Setting") ?? Setting(Alarm: ".defaultSound", Back: ".none")
    }
    

    func loadSetting() {
        self.set = SettingDataManager.loadSetting(forKey: "Setting") ?? Setting(Alarm: ".defaultSound", Back: ".none")
    }
    
    let alarmOptions: [AlarmSound] = [
        .sound1, .sound2, .sound3, .sound4, .none
    ]
    
    let SoundOptions: [BackgroundSound] = [
        .b_sound1, .b_sound2,.none
    ]
    
    
    enum AlarmSound: String, CaseIterable {
        case sound1 = "종.mp3"
        case sound2 = "페이지 넘김.mp3"
        case sound3 = "물.mp3"
        case sound4 = "커피 만들기.mp3"
//        case defaultSound = ".defaultSound"
        case none = "없음.mp3"
    }
    
    enum BackgroundSound: String, CaseIterable {
        case b_sound1 = "해안가"
        case b_sound2 = "캠프파이어"
        case none = "없음"
    }
}

