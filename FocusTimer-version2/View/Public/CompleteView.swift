//
//  Completeview.swift
//  FocusTimer-version2
//
//  Created by 이영호 on 9/24/24.
//

import SwiftUI

struct CompleteView: View {
    var onReturn: () -> Void
    @ObservedObject var todoViewModel: TodoViewModel
    
    var body: some View {
        
        VStack {
//            List {
//                ForEach(todoViewModel.todoItems.filter { $0.isActive}) { item in
//                    Text(item.title)
//                        .padding()
//                        .background(Color.gray.opacity(0.2))
//                        .cornerRadius(8)
//                        .padding(.vertical, 2)
//                }
//            }
//            .listStyle(PlainListStyle())
//            .padding()
            
            Button(action: {
                onReturn()
            }) {
                Text("다시 시작")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle("완료된 항목")
        .padding()
    }
}


//
//#Preview {
//    CompleteView(onReturn: {
//     print("Return Timer")
//    }
//    , todoViewModel: TodoViewModel())
//}
