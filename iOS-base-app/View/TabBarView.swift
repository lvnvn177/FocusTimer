//
//  TabBarView.swift
//  iOS-base-app
//
//  Created by 이영호 on 9/22/24.
//

import SwiftUI

struct TabBarView: View {
    
    @Binding var selectedView: String
   
    @ObservedObject var mainViewModel: MainViewModel
    @ObservedObject var seocndViewModel: SecondViewModel
    @ObservedObject var settingViewModel: SettingViewModel
    
    var body: some View {
        TabView(selection: $selectedView) {
            MainView(viewModel: MainViewModel())
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
        mainViewModel: MainViewModel(),
        seocndViewModel: SecondViewModel(),
        settingViewModel: SettingViewModel()
    )
}
