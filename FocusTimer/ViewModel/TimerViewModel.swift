//
//  MainViewModel.swift
//  iOS-base-app
//
//  Created by 이영호 on 9/22/24.
//

import Foundation
import AVFoundation
import UserNotifications
import UIKit

import SwiftUI
import ActivityKit

import AudioPlayerManager
import NotificationManager

class TimerViewModel: ObservableObject {
    static let shared = TimerViewModel(settingViewModel: SettingViewModel(), focusCalendarViewModel: FocusCalendarViewModel())
    
    @Published var timeRemaining: Int = 0 // 현재 남은 시간
    @Published var selectedHours: Int = 0 // 사용자가 TimePicker에서 설정한 시간
    @Published var selectedMinutes: Int = 0
    @Published var selectedSeconds: Int = 0
    
    @Published var isRunning: Bool = false // 타이머 작동 상태
    @Published var showingTodoList: Bool = false // TodoList 설정 시 활성화 되는 뷰
    @Published var showCompleteView: Bool = false // 타이머가 끝났을때 활성화 되는 뷰
    
    
    @ObservedObject var settingViewModel: SettingViewModel
    
    
    var focusCalendarViewModel: FocusCalendarViewModel
    
    let audioManager = AudioPlayerManager.shared
    
   
    
    init(settingViewModel: SettingViewModel, focusCalendarViewModel: FocusCalendarViewModel) {
            print("init 호출됨")
     
            self.settingViewModel = settingViewModel
            self.focusCalendarViewModel = focusCalendarViewModel
//            
//            UIDevice.current.beginGeneratingDeviceOrientationNotifications()
//            NotificationCenter.default.addObserver(self, selector: #selector(handleDeviceOrientationChange), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    private var timer: Timer? // 타이머
//    private var player: AVAudioPlayer? // inactive, background 상태에서 활성화 되는 AudioSession
   
    var totalTime: Int { // 총 시간, 설정한 시간을 해당 함수를 통해 모두 더해서 타이머 값으로 설정
            (selectedHours * 3600) + (selectedMinutes * 60) + selectedSeconds
    }
    
    var progress: CGFloat { // 현재 남은 시간을 보여주는 게이지
        guard totalTime > 0 else { return 1.0 }
        return CGFloat(timeRemaining) / CGFloat(totalTime)
    }
    
    
    func setTimer() {
        timeRemaining = totalTime
        print("Time remaining set to \(timeRemaining) seconds")
    }
    
    func startTimer() {
            guard !isRunning else { return } // 중복 실행 방지
            stopTimer()
            isRunning = true
            
            print("check_back:", settingViewModel.set.Back)
        audioManager.playBackgroundAudio(named: settingViewModel.set.Back, withExtension: "mp3")
            if timeRemaining <= 0 {
                timeRemaining = totalTime
//                audioManager.stopAudio()
            }
            startLiveActivity()
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in // 1초 마다 실행되는 함수
                self.updateTimer() // 현재 타이머의 남은 시간을 확인
            }
        }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        isRunning = false
        
        audioManager.stopAudio()
        stopLiveActivity()
    }
    
    func resetTimer() {
        stopLiveActivity()
        timeRemaining = totalTime
        timer?.invalidate()
        timer = nil
        isRunning = false
        audioManager.stopAudio()
        
    }
    
    func startLiveActivity() {
        let startTime =  Date()
        let endTime = startTime.addingTimeInterval(TimeInterval(totalTime))
        let timerRange = startTime...endTime
        
        let attributes = TimerAttributes(totalTime: TimeInterval(totalTime), name: "Focus Timer")
        let initialState = TimerAttributes.ContentState(remainingTime: TimeInterval(timeRemaining), timer: timerRange)
        let content = ActivityContent(state: initialState, staleDate: .now.addingTimeInterval(TimeInterval(totalTime)))
        
        do {
            let activity = try Activity<TimerAttributes>.request(attributes: attributes, content: content, pushType: nil)
            print("Live Activity started with ID: \(activity.id)")
        } catch {
            print("Failed to start Live Activity: \(error)")
        }
    }
    
    func updateLiveActivity() {
        guard let activity = Activity<TimerAttributes>.activities.first else { return }
        
        let startTime = Date()
        let endTime = startTime.addingTimeInterval(TimeInterval(timeRemaining))
        let timerRange = startTime...endTime
        
        let updatedState = TimerAttributes.ContentState(remainingTime: TimeInterval(timeRemaining), timer: timerRange)
        
        _ = ActivityContent(state: updatedState, staleDate: .now.addingTimeInterval(30))
        
        Task {
            let content = ActivityContent(state: updatedState, staleDate: .now.addingTimeInterval(TimeInterval(timeRemaining)))
            await activity.update(content)
            print("Live Activity updated with remaining time: \(timeRemaining)")
        }
    }
    
    func stopLiveActivity() {
        guard let activity = Activity<TimerAttributes>.activities.first else { return }
        
        let finalState = TimerAttributes.ContentState(
            remainingTime: 0, 
            timer: Date()...Date()
        )
        let content = ActivityContent(state: finalState, staleDate: .now)
        
        Task {
            await activity.end(content, dismissalPolicy: .immediate)
            print("Live Activity ended")
        }
    }
    
   private func updateTimer() {
       if timeRemaining > 0 { // 남아 있은 시간이 있으면 1초가 지나감
           timeRemaining -= 1
           updateLiveActivity()
           print(timeRemaining)
       } else {
           stopTimer() // 타이머가 다 될시 foreground 상태에서는 AVAudioSession, inactive 또는 background 상태에서는
                       // UNNotificationSound를 이용하여 알림음 활성화
           let selectedSound = settingViewModel.set.Alarm
           
           if UIApplication.shared.applicationState == .active {
               // 포그라운드일 때는 알람 소리 재생
               playAlarmSound()
           } else {
               // 백그라운드/비활성화 상태일 때는 시스템 알림 소리만
               print("sound active: ", settingViewModel.set.Alarm)
               
               PushNotificationManager.shared.scheduleLocalNotification(
                title: "집중 끝",
                body: "수고하셨습니다!",
                sound: UNNotificationSound(named: UNNotificationSoundName(rawValue: selectedSound)))
           }
           recordFocustime()
           audioManager.stopAudio()
           showCompleteView = true // 타이머가 다 되면 완료화면 활성화
       }
   }
    
    func playAlarmSound() {
        let selectedSound = settingViewModel.set.Alarm
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            if !audioSession.isOtherAudioPlaying {
                try audioSession.setCategory(.playback, mode: .default, options: .duckOthers)
                try audioSession.setActive(true)
            }
            
            if let soundName = selectedSound.split(separator: ".").first {
                if let url = Bundle.main.url(forResource: String(soundName) ,withExtension: "mp3") {
                    audioManager.audioPlayer = try AVAudioPlayer(contentsOf: url)
                    audioManager.audioPlayer?.play()
                }
            }
            
            
        } catch let error as NSError {
            print("Error: \(error.localizedDescription), code: \(error.code)")
        }
    }
    
    func stopAlarmSound() {
        audioManager.audioPlayer?.stop()
        audioManager.audioPlayer = nil
        
        do {
            try AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
        } catch let error as NSError {
            print("Error stopping AVAudioSession: \(error.localizedDescription), code: \(error.code)")
        }
    }
    
    private func recordFocustime() {
        let focusTime = totalTime - timeRemaining
      
        let today = DateToString(date: Date())
//        print("recordFocustime:", today)
        focusCalendarViewModel.addFocusRecord(for: today, focusTime: focusTime)
    }
    
    func DateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
}
