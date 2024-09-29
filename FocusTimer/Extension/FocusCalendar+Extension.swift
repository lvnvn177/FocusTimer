//
//  FocusCalendar+Extension.swift
//  FocusTimer-version2
//
//  Created by 이영호 on 9/25/24.
//

import Foundation

// Date에 대한 확장
extension Date {
    // 주어진 월 수만큼 날짜를 변경하는 함수
    func changeMonth(by offset: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .month, value: offset, to: self) ?? self
    }
    
    // 날짜를 "yyyy.MM" 형식으로 반환하는 함수
    func toYearMonthFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM" // 년.월 형식
        return formatter.string(from: self)
    }

    // 해당 월의 모든 날짜를 생성하는 함수
//    func generateDatesForMonth() -> [Date] {
//        let calendar = Calendar.current
//        let range = calendar.range(of: .day, in: .month, for: self)!
//        let components = calendar.dateComponents([.year, .month], from: self)
//        var dates: [Date] = []
//        
//        for day in range {
//            if let date = calendar.date(from: DateComponents(year: components.year, month: components.month, day: day)) {
//                dates.append(date)
//            }
//        }
//        
//        return dates
//    }
}
