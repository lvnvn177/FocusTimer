//
//  SecondView.swift
//  iOS-base-app
//
//  Created by 이영호 on 9/22/24.
//


import SwiftUI

struct FocusCalendarView: View {
    @ObservedObject var viewModel: FocusCalendarViewModel

    @State private var currentMonth: Date = Date() // 현재 달을 추적하는 변수

    // 색상 결정: 집중 시간이 많을수록 색이 진해짐
    private func colorForFocusTime(_ focusTime: Int) -> Color {
        switch focusTime {
        case 0: return Color.gray.opacity(0.1)
        case 1...30: return Color.green.opacity(0.2)
        case 31...60: return Color.green.opacity(0.4)
        case 61...90: return Color.green.opacity(0.6)
        case 91...120: return Color.green.opacity(0.8)
        default: return Color.green.opacity(0.1)
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                // 이전 달로 이동하는 버튼
                Button(action: {
                    currentMonth = currentMonth.changeMonth(by: -1)
                }) {
                    Image(systemName: "arrow.left")
                        .padding()
                }
                
                // 현재 달 표시
                Text(currentMonth.toYearMonthFormat())
                    .font(.headline)
                    .padding()
                
                // 다음 달로 이동하는 버튼
                Button(action: {
                    currentMonth = currentMonth.changeMonth(by: 1)
                }) {
                    Image(systemName: "arrow.right")
                        .padding()
                }
            }
            
            let columns = Array(repeating: GridItem(.flexible(), spacing: 5), count: 7) // 7열로 설정 (월~일)
            
            HStack(spacing: 5) {
                ForEach(["S ", "M", "T", "W", "T", "F", "S"], id: \.self) { day in
                        Text(day)
                            .font(.caption)
                            .fontWeight(.bold)
                            .frame(width: 40, height: 40)
                            .multilineTextAlignment(.center)
                            .padding(.trailing, 5)
                }
            }
            .padding(.bottom, 5)
            
            LazyVGrid(columns: columns, spacing: 5) {
                ForEach(generateDatesForMonth(), id: \.self) { date in
                    if let date = date {
                        let focusTime = viewModel.focusTime(for: date) // 정수형으로 직접 사용

                        colorForFocusTime(focusTime)
                            .frame(width: 40, height: 40)
                            .cornerRadius(4)
                            .overlay(
                                Text(focusTime > 0 ? "\(RecordFormat(record: focusTime))" : "")
                                    .font(.caption2)
                                    .foregroundColor(.white)
                            )
                    } else {
                        // 날짜가 없는 경우 빈 칸 처리
                        Color.clear
                            .frame(width: 40, height: 40)
                    }
                }
            }
            .padding()
        }
        .background(Color.white)
        .onAppear {
            viewModel.loadRecords()
        }
    }
    func generateDatesForMonth() -> [String?] {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: currentMonth)
        
        guard let firstDayofMonth = calendar.date(from: components) else { return [] }
        
        let weekday = calendar.component(.weekday, from: firstDayofMonth) - 1
        
        var dates: [String?] = Array(repeating: nil, count: weekday)
        
        let range = calendar.range(of: .day, in: .month, for: currentMonth)!
        for day in range {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: firstDayofMonth) {
                let dateString = DateToString(date: date)
                dates.append(dateString)
            }
        }
        
        return dates
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



#Preview {
    FocusCalendarView(viewModel: FocusCalendarViewModel())
}
