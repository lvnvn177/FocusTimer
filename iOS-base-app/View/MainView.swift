//
//  MainView.swift
//  iOS-base-app
//
//  Created by 이영호 on 9/22/24.
//

import SwiftUI
import iOS_Module

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    
    @State private var items: [Sample] = []
    @State private var isMenuVisible: Bool = false // 메뉴 가시성을 관리하는 상태 변수
    
    let SampleDataManager = DataManager<Sample>()
    
    var body: some View {
        ZStack {
            // 메인 콘텐츠
            VStack {
                Text("Main Content")
                    .font(.headline)
                    .padding()

                List(items) { item in
                    Text(item.name)
                }

                Spacer()

                // 메뉴를 열고 닫는 버튼 (오른쪽 하단에 위치)
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation {
                            isMenuVisible.toggle() // 메뉴 가시성을 전환
                        }
                    }) {
                        Image(systemName: isMenuVisible ? "xmark.circle.fill" : "line.horizontal.3")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .padding()
                    }
                }
            }
            .onAppear {
                PushNotificationManager.shared.requestAuthorization()
            }

            // 사이드 메뉴
            if isMenuVisible {
                HStack {
                    VStack {
                        Text("Side")
                            .font(.headline)
                            .padding()

                        Button(action: {
                            // 푸시 알림
                            PushNotificationManager.shared.scheduleLocalNotification(
                                title: "TEST Banner",
                                body: "Check Please",
                                sound: UNNotificationSound.default
                            )
                        }) {
                            Image(systemName: "mail")
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                        .padding()

                        Button(action: {
                            // 샘플 아이템 저장
                            let sampleItems = [
                                Sample(id: UUID(), name: "Items1"),
                                Sample(id: UUID(), name: "Items2"),
                                Sample(id: UUID(), name: "Items3")
                            ]
                            SampleDataManager.saveItem(sampleItems)
                            print("Items saved!")
                        }) {
                            Image(systemName: "square.and.arrow.down")
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                        .padding()

                        Button(action: {
                            // 샘플 아이템 로드
                            items = SampleDataManager.loadItem()
                            print("Items loaded!")
                        }) {
                            Image(systemName: "book")
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                        .padding()

                        Spacer() // 아래 공간 확보
                    }
                    .frame(maxWidth: 70) // 사이드 메뉴 너비 설정
                    .background(Color.gray.opacity(0.9)) // 배경색 설정
                    .transition(.move(edge: .leading)) // 왼쪽에서 이동하는 애니메이션
                    .animation(.default, value: isMenuVisible)

                    Spacer() // 사이드 메뉴가 차지하지 않는 나머지 공간
                }
            }
        }
    }
}

#Preview {
    MainView(viewModel: MainViewModel())
}
