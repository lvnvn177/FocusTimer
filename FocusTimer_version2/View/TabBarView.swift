//
//  TabBarView.swift
//  iOS-base-app
//
//  Created by 이영호 on 9/22/24.
//

import SwiftUI

struct TabBarView: View {
    
    @Binding var selectedView: String
   
    @ObservedObject var timerViewModel: TimerViewModel
    @ObservedObject var seocndViewModel: SecondViewModel
    @ObservedObject var settingViewModel: SettingViewModel
    
    var body: some View {
        TabView(selection: $selectedView) {
            TimerView(viewModel: TimerViewModel())
                .tabItem {
                    Image(systemName: "paperplane")
                }
                .tag("MainView")
            
            SecondView(viewModel: SecondViewModel())
                .tabItem {
                    Image(systemName: "clipboard")
                }
                .tag("SecondView")
            
            SettingView()
                .tabItem {
                    Image(systemName: "gearshape")
                }
                .tag("SettingView")
            
                .tint(.black)
        }
    }
}

#Preview {
    TabBarView(
        selectedView: .constant("MainView"),
        timerViewModel: TimerViewModel(),
        seocndViewModel: SecondViewModel(),
        settingViewModel: SettingViewModel()
    )
}
