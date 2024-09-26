//
//  ContentView.swift
//  iOS-base-app
//
//  Created by 이영호 on 9/22/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedView = "MainView"
    @StateObject var settingViewModel = SettingViewModel()
    @StateObject var timerViewModel = TimerViewModel(settingViewModel: SettingViewModel(), focusCalendarViewModel: FocusCalendarViewModel())
    @ObservedObject var focusCalendarViewModel = FocusCalendarViewModel()
    
    var body: some View {
        TabBarView(
            selectedView: $selectedView,
            timerViewModel: timerViewModel,
            focusCalendarViewModel: FocusCalendarViewModel(),
            settingViewModel: settingViewModel,
            todoViewModel: TodoViewModel()
        )
        .onAppear {
            focusCalendarViewModel.loadRecords()
        }
    }
        
}

#Preview {
    ContentView()
}
