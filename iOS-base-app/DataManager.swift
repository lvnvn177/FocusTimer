//
//  DataManager.swift
//  iOS-base-app
//
//  Created by 이영호 on 9/23/24.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    private let itemsKey = "sample"
    private init() {}
    
    func saveItem(_ items: [Sample]) {
        let encoder = JSONEncoder()
        
        if let encodedData = try? encoder.encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
    
    func loadItem() -> [Sample] {
        if let saveData = UserDefaults.standard.data(forKey: itemsKey) {
            let decoder = JSONDecoder()
            if let decodedItems = try? decoder.decode([Sample].self, from: saveData) {
                return decodedItems
            }
        }
        
        return []
    }
}
