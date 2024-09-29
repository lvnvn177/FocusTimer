//
//  NotificaitonSoundSelecitonView.swift
//  FocusTimer-version2
//
//  Created by 이영호 on 9/26/24.
//

import SwiftUI

struct SoundSelectionView: View {
    
    @ObservedObject var settingViewModel: SettingViewModel
    
    var body: some View {
        Form {
            Section {
                ForEach(settingViewModel.alarmOptions, id: \.self) { sound in
                    HStack {
                        Text(sound.rawValue.replacingOccurrences(of: ".mp3", with: ""))
                        Spacer()
                        if settingViewModel.set.Alarm == sound.rawValue {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.blue)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        print("sound_check:", sound.rawValue)
                        settingViewModel.set = Setting(Alarm: sound.rawValue, Back: settingViewModel.set.Back)
//                        print("SettingView에서 선택한 알림음: \(settingViewModel.setting.append())!!!!")
                    }
                }
            } header: {
                Text("알림음 선택")
                    .font(.headline)
                    .fontWeight(.bold)
            }
            
            Section {
                ForEach(settingViewModel.SoundOptions, id: \.self) { sound in
                    HStack {
                        Text(sound.rawValue)
                        Spacer()
                        if settingViewModel.set.Back == sound.rawValue {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.blue)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        print("sound_back_check:", sound.rawValue)
                        settingViewModel.set = Setting(Alarm: settingViewModel.set.Alarm, Back: sound.rawValue)
                    }
                }
            } header: {
                 Text("배경음 선택")
                    .font(.headline)
                    .fontWeight(.bold)
            }
        }
        .navigationTitle("소리 설정")
    }
}

#Preview {
    SoundSelectionView(settingViewModel: SettingViewModel())
}
