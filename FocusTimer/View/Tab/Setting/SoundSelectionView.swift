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
                    ZStack {
                        if settingViewModel.set.Alarm == sound.rawValue {
                            Color("Setting").opacity(0.9) // Color for selected item
                       } else {
                           Color.clear // Default color for non-selected items
                       }
                        HStack {
                            Text(sound.rawValue.replacingOccurrences(of: ".mp3", with: ""))
                                .foregroundStyle(
                                    settingViewModel.set.Alarm == sound.rawValue ? .white : .primary
                                )
                               
                        }
                        .clipShape(.rect(cornerRadius: 10))
                        .contentShape(Rectangle())
                        .onTapGesture {
                            print("sound_check:", sound.rawValue)
                            settingViewModel.set = Setting(
                                Alarm: sound.rawValue,
                                Back: settingViewModel.set.Back
                            )
    //                        print("SettingView에서 선택한 알림음: \(settingViewModel.setting.append())!!!!")
                        }
                    }
            
                }
            } header: {
                Text("알림음")
                    .font(.headline)
                    .fontWeight(.bold)
            }
            
            Section {
                ForEach(settingViewModel.SoundOptions, id: \.self) { sound in
                    ZStack {
                        if settingViewModel.set.Back == sound.rawValue {
                            Color("Setting").opacity(0.9) // Color for selected item
                       } else {
                           Color.clear // Default color for non-selected items
                       }
                        HStack {
                            Text(sound.rawValue)
                                .foregroundStyle(
                                    settingViewModel.set.Back == sound.rawValue ? .white : .primary
                                )
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            print("sound_back_check:", sound.rawValue)
                            settingViewModel.set = Setting(
                                Alarm: settingViewModel.set.Alarm,
                                Back: sound.rawValue
                            )
                        }
                    }
                  
                }
            } header: {
                 Text("배경음")
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
