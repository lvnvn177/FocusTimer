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
    @ObservedObject var focusCalendarViewModel: FocusCalendarViewModel
    @ObservedObject var settingViewModel: SettingViewModel
    @ObservedObject var todoViewModel: TodoViewModel
    
    var body: some View {
        TabView(selection: $selectedView) {
            TimerView(viewModel: TimerViewModel(settingViewModel: SettingViewModel(), focusCalendarViewModel: FocusCalendarViewModel()), todoViewModel: todoViewModel, FocusModel: FocusCalendarViewModel(), settingViewModel: SettingViewModel())
                .tabItem {
                    Image(systemName: "paperplane")
                }
                .tag("MainView")
            
            FocusCalendarView(viewModel: FocusCalendarViewModel())
                .tabItem {
                    Image(systemName: "clipboard")
                }
                .tag("SecondView")
            
            SettingView(settingViewModel: settingViewModel)
                .tabItem {
                    Image(systemName: "gearshape")
                }
                .tag("SettingView")
            
                .tint(.black)
        }
    }
}

#Preview {
    TabBarView(selectedView: .constant("TimerView"), 
               timerViewModel: TimerViewModel(settingViewModel: SettingViewModel(), focusCalendarViewModel: FocusCalendarViewModel()),
               focusCalendarViewModel: FocusCalendarViewModel(),
               settingViewModel: SettingViewModel(),
               todoViewModel: TodoViewModel())
}
