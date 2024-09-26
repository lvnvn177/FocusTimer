//
//  TodoView.swift
//  FocusTimer-version2
//
//  Created by 이영호 on 9/24/24.
//

import SwiftUI

struct TodoView: View {
    @ObservedObject var todoViewModel: TodoViewModel
    @State private var showAddTodoAlert = false
    @State private var newTodoTitle = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(todoViewModel.todoItems) { item in
                    HStack {
                        Toggle(isOn: Binding(
                            get: { item.isActive },
                            set: { _ in todoViewModel.toggleTodoItem(item) }
                        )) {
                            Text(item.title)
                        }
                    }
                }
                .onDelete(perform: todoViewModel.deleteTodoItem)
            }
            .navigationTitle("Todo List")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showAddTodoAlert = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .alert("새로운 할 일 추가", isPresented: $showAddTodoAlert) {
                TextField("할 일 제목을 입력하세요", text: $newTodoTitle)
                Button("추가", action: {
                    todoViewModel.addTodoItem(title: newTodoTitle)
                    newTodoTitle = ""
                })
                Button("취소", role: .cancel, action: {})
            }
        }
    }
}

#Preview {
    TodoView(todoViewModel: TodoViewModel())
}
