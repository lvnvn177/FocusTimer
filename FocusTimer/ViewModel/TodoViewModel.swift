//
//  TodoViewModel.swift
//  FocusTimer-version2
//
//  Created by 이영호 on 9/24/24.
//

import Foundation
import SwiftUI
import iOS_Module

class TodoViewModel: ObservableObject {
    
    private let itemsKey = "todoItems"
    
//    let TodoDataManager = DataManager<TodoItem>()
    
    @Published var todoItems: [TodoItem] = [] {
        didSet {
            print("test2")
//            TodoDataManager.saveItem(todoItems)
        }
    }
    
    init() {
        print("test1")
//        self.todoItems = TodoDataManager.loadItem()
    }
    
    func addTodoItem(title: String) {
        let newItem = TodoItem(title: title)
        todoItems.append(newItem)
    }
    
    func deleteTodoItem(at offsets: IndexSet) {
        todoItems.remove(atOffsets: offsets)
    }
    
    func toggleTodoItem(_ item: TodoItem) {
        if let index = todoItems.firstIndex(where: { $0.id == item.id}) {
            todoItems[index].isActive.toggle()
        }
    }
}
