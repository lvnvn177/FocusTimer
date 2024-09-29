//
//  LongPressGestureView.swift
//  FocusTimer-version2
//
//  Created by 이영호 on 9/29/24.
//

import UIKit
import SwiftUI

// UIViewRepresentable을 사용하여 UILongPressGestureRecognizer를 SwiftUI에서 사용할 수 있도록 설정
struct LongPressGestureView: UIViewRepresentable {
    
    var onLongPress: () -> Void // 롱프레스 이벤트 핸들러
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        let longPressRecognizer = UILongPressGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleLongPress(_:)))
        view.addGestureRecognizer(longPressRecognizer) // 제스처 인식기 추가
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
    
    // Coordinator로 Objective-C 메서드를 처리
    func makeCoordinator() -> Coordinator {
        Coordinator(onLongPress: onLongPress)
    }

    class Coordinator: NSObject {
        var onLongPress: () -> Void

        init(onLongPress: @escaping () -> Void) {
            self.onLongPress = onLongPress
        }

        @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
            if gesture.state == .began {
                onLongPress() // 롱프레스가 시작되면 이벤트 호출
            }
        }
    }
}
