//
//  SecondViewModel.swift
//  iOS-base-app
//
//  Created by 이영호 on 9/22/24.
//

import Foundation
import iOS_Module

class FocusCalendarViewModel: ObservableObject {
    
    let FocusDataManager = DataManager<Record>()
    
    @Published var focusRecords: [Record] = [] {
        didSet {
            FocusDataManager.saveItem(focusRecords)
            print("Current Records after saving:", focusRecords)
        }
    }
    
    init() {
        self.focusRecords = FocusDataManager.loadItem()
        
        print("Loaded focus records: \(self.focusRecords)")
    }
    
    func loadRecords() {
        self.focusRecords = FocusDataManager.loadItem()
    }
    
    func addFocusRecord(for date: String, focusTime: Int) {
//        objectWillChange.send()
      
        if let index = focusRecords.firstIndex(where: { $0.date == date }) {
            focusRecords[index].Time += focusTime
            print("FocusTime:",focusRecords[index].Time)
        } else {
            
            let newRecord = Record(date: date, Time: focusTime)
          
            print("Final TEST \(newRecord.date): \(newRecord.Time)")
            focusRecords.append(newRecord)
            print("Current focusRecords after append:", focusRecords)
            print("check_load:", FocusDataManager.loadItem())
            
        }
    }
    
    func focusTime(for date: String) -> Int {
        print("FFFF:",focusRecords)
        for record in focusRecords {
            print("Checking record date:", record.date, "with input date:", date)
            if record.date == date {
                print("Match found with focus time:", record.Time)
                return record.Time
            }
        }
        print("No match found for date:", date)
        return 0
    }
    
    func DateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}
