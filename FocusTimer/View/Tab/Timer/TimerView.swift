//
//  MainView.swift
//  iOS-base-app
//
//  Created by 이영호 on 9/22/24.
//

import SwiftUI
import UIKit
import iOS_Module

struct TimerView: View {
    @ObservedObject var viewModel: TimerViewModel
    @ObservedObject var todoViewModel: TodoViewModel // TodoViewModel을 외부에서 받아서 사용
    
    @State private var showingStopAlert = false // Alert 표시 여부
    

    @ObservedObject var FocusModel: FocusCalendarViewModel
    @ObservedObject var settingViewModel: SettingViewModel
    
    let audioManager = AudioPlayerManager.shared

    var body: some View {
        NavigationStack {
            VStack {
                
                ZStack {
                    Circle()
                        .stroke(lineWidth: 20)
                        .opacity(0.3)
                        .foregroundStyle(Color.gray)
                    
                    Circle()
                        .trim(from: 0, to: 1 - viewModel.progress)
                        .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                        .foregroundStyle(Color(red: 144/255, green: 238/255, blue: 144/255))
                        .rotationEffect(.degrees(-90))
                        .animation(.linear, value: viewModel.timeRemaining)
                        
                    
                    
                    if viewModel.isRunning {
                        Text(viewModel.timeRemaining.timeString)
                            .font(.largeTitle)
                            .padding()
                    } else {
                        Picker("Minutes", selection: $viewModel.selectedMinutes) {
                            ForEach(0..<121) { minute in
                                Text("\(minute)").tag(minute)
                            }
                        }
                        .labelsHidden()
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: 80)
                        .font(.largeTitle)
                    }
                    
                }
                .frame(maxWidth: 300, maxHeight: 300)
                .padding(70)
//                VStack {
//                    if viewModel.isRunning {
//                        Text(viewModel.timeRemaining.timeString)
//                            .font(.largeTitle)
//                            .padding()
//                    }
//                }
//                .padding(.bottom, 150)
                
                HStack {
                    Button(action: {
                        print("",settingViewModel.set.Alarm)
                        viewModel.isRunning ? viewModel.stopTimer() : viewModel.startTimer()
                        
                    }) {
                        Image(systemName: viewModel.isRunning ? "stop.circle" : "play.circle")
                            .font(.system(size: 60))
                            .foregroundStyle(viewModel.isRunning ? .red : .black)
                    }
                    .simultaneousGesture(
                            LongPressGesture(minimumDuration: 1.0)
                                .onEnded { _ in
                                    showingStopAlert = true
                                    let generator = UIImpactFeedbackGenerator(style: .medium)
                                    generator.impactOccurred()
                                }
                        )
                }
                .confirmationDialog("title", isPresented: $showingStopAlert) {
                    Button(action: {
                      
                        viewModel.resetTimer()
                       
                    }) {
                        Text("집중 그만하기")
                            .foregroundStyle(.black)
                            .padding()
                            .background(Color.white)
                            .clipShape(.capsule)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                    }
                }
                .padding()
                .sheet(isPresented: $viewModel.showingTodoList) {
                    TodoView(todoViewModel: TodoViewModel())
                }
                .navigationDestination(isPresented: $viewModel.showCompleteView) {
                    CompleteView(viewModel: FocusCalendarViewModel())
                }
                
                
            }
            .onAppear {
              
                PushNotificationManager.shared.requestAuthorization()
                FocusModel.loadRecords()
                print("Appear:", FocusModel.focusRecords)
            }
        }
        
    }
        

        
}

#Preview {
    TimerView(viewModel: TimerViewModel(settingViewModel: SettingViewModel(), focusCalendarViewModel: FocusCalendarViewModel()), todoViewModel: TodoViewModel(), FocusModel: FocusCalendarViewModel(), settingViewModel: SettingViewModel())
}
