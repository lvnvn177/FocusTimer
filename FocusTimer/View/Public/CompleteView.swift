//
//  Completeview.swift
//  FocusTimer-version2
//
//  Created by 이영호 on 9/24/24.
//

import SwiftUI

struct CompleteView: View {
    @ObservedObject var viewModel: FocusCalendarViewModel
    
//    var onReturn: () -> Void
    
    
    var body: some View {
        
        VStack {
            
            
            Button(action: {
               
            }) {
                Text("오늘의 집중 : \(RecordFormat(record: findTime(for: DateToString(date: Date()), in: viewModel.focusRecords) ?? 0))")
                    .font(.title)
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(10)
            }
            .padding()
        }
        //        .navigationTitle("완료된 항목")
        .padding()
    }
    
    func findTime(for date: String, in records: [Record]) -> Int? {
        return records.first { $0.date == date }?.Time
    }
    
    func DateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    func RecordFormat(record: Int) -> String {
        let minutes = record / 60  // 분
        let seconds = record % 60  // 초

        // mm:ss 형식으로 반환
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
