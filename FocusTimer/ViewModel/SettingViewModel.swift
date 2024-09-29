//
//  SettingViewModel.swift
//  iOS-base-app
//
//  Created by 이영호 on 9/22/24.
//

import Foundation
import iOS_Module

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
        .sound1, .sound2, .defaultSound, .none
    ]
    
    let SoundOptions: [BackgroundSound] = [
        .b_sound1, .b_sound2, .none
    ]
    
    
    enum AlarmSound: String, CaseIterable {
        case sound1 = "alarm_water.mp3"
        case sound2 = "alarm_pages.mp3"
        case defaultSound = ".defaultSound"
        case none = "nonesound.mp3"
    }
    
    enum BackgroundSound: String, CaseIterable {
        case b_sound1 = "campfire"
        case b_sound2 = "grinder"
        case none = "nonesound"
    }
}

