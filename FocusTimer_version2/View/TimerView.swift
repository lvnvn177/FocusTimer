//
//  MainView.swift
//  iOS-base-app
//
//  Created by 이영호 on 9/22/24.
//

import SwiftUI
import iOS_Module

struct TimerView: View {
    @ObservedObject var viewModel: TimerViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                HStack {
                    Button(action: {
                        
                    }) {
                        Text("오늘 할 일")
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
                
                ZStack {
                    Circle()
                        .stroke(lineWidth: 20)
                        .opacity(0.3)
                        .foregroundStyle(Color.gray)
                    
                    Circle()
                        .trim(from: 0, to: 1 - viewModel.progress)
                }
            }
        }
    }
}

#Preview {
    TimerView(viewModel: TimerViewModel())
}
