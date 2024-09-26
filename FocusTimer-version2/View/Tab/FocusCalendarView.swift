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
        case 1...30: return Color.green.opacity(0.3)
        case 31...60: return Color.green.opacity(0.6)
        case 61...120: return Color.green.opacity(0.8)
        default: return Color.green
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
            
//            HStack(spacing: 5) {
//                ForEach(["S ", "M", "T", "W", "T", "F", "S"], id: \.self) { day in
//                        Text(day)
//                            .font(.caption)
//                            .fontWeight(.bold)
//                            .frame(width: 40, height: 40)
//                            .multilineTextAlignment(.center)
//                            .padding(.trailing, 5)
//                }
//            }
//            .padding(.bottom, 5)
            
            LazyVGrid(columns: columns, spacing: 5) {
                ForEach(generateDatesForMonth(), id: \.self) { date in
                    let focusTime = viewModel.focusTime(for: date)
                    let _ = print("Date:",date)
                    let _ = print("Focus time for date \(date): \(focusTime)")
                    
                    colorForFocusTime(focusTime)
                        .frame(width: 40, height: 40)
                        .cornerRadius(4)
                        .overlay(
                            Text(focusTime > 0 ? "\(focusTime)" : "")
                                .font(.caption2)
                                .foregroundColor(.white)
                        )
                }
            }
            .padding()
        }
        .background(Color.white)
    }
    func generateDatesForMonth() -> [String] {
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: currentMonth)!
        let components = calendar.dateComponents([.year, .month], from: currentMonth)
        var dates: [String] = []
        
        for day in range {
            if let date = calendar.date(from: DateComponents(year: components.year, month: components.month, day: day)) {
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
}



#Preview {
    FocusCalendarView(viewModel: FocusCalendarViewModel())
}
