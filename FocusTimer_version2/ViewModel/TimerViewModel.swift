//
//  MainViewModel.swift
//  iOS-base-app
//
//  Created by 이영호 on 9/22/24.
//

import Foundation

class TimerViewModel: ObservableObject {
    @Published var timeRemaining: Int = 0 // 현재 남은 시간
    @Published var selectedHours: Int = 0 // 사용자가 TimePicker에서 설정한 시간
    @Published var selectedMinutes: Int = 0
    @Published var selectedSeconds: Int = 0
    
    var totalTime: Int { // 총 시간, 설정한 시간을 해당 함수를 통해 모두 더해서 타이머 값으로 설정
            (selectedHours * 3600) + (selectedMinutes * 60) + selectedSeconds
    }
    
    var progress: CGFloat {
        guard totalTime > 0 else { return 1.0 }
        return CGFloat(timeRemaining) / CGFloat(totalTime)
    }
}
