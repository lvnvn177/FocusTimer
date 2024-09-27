//
//  SettingView.swift
//  iOS-base-app
//
//  Created by 이영호 on 9/22/24.
//

import SwiftUI

struct SettingView: View {
    
    @ObservedObject var settingViewModel: SettingViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        NavigationLink(destination: SoundSelectionView(settingViewModel: settingViewModel)) {
                            Text("알림 및 백그라운드")
                        }
                    } header: {
                        Text("사운드")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.bottom, 5)
                    }
                    
                    Section {
                        NavigationLink(destination: ControlView()) { 
                            Text("제어")
                        }
                    } header: {
                        Text("제어")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.bottom, 5)
                    }
                }
            }
        }
    }
}

#Preview {
    SettingView(settingViewModel: SettingViewModel())
}
