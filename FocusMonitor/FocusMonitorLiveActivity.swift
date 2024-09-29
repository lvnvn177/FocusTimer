//
//  FocusMonitorLiveActivity.swift
//  FocusMonitor
//
//  Created by 이영호 on 9/29/24.
//

import ActivityKit
import WidgetKit
import SwiftUI
import NotificationCenter
//struct FocusMonitorAttributes: ActivityAttributes {
//    public struct ContentState: Codable, Hashable {
//        // Dynamic stateful properties about your activity go here!
//        var emoji: String
//    }
//
//    // Fixed non-changing properties about your activity go here!
//    var name: String
//}

struct FocusMonitorLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TimerAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("남은 시간")
                    .font(.headline)
                    .foregroundStyle(.black)
                Text(timerInterval: context.state.timer, countsDown: true)
                    .font(.system(size: 44, weight: .semibold))
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.center)
                Button(action: {
                    
                }) {
                    
                }
                
            }
            .padding()
            .activityBackgroundTint(.white)
            .activitySystemActionForegroundColor(.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("타이머")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text(timerInterval: context.state.timer, countsDown: true)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("화이팅")
                    // more content
                }
            } compactLeading: {
                Text("😀")
            } compactTrailing: {
                Text(timerInterval: context.state.timer, countsDown: true)
            } minimal: {
                Text("😀")
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

//extension TimerAttributes {
//    fileprivate static var preview: TimerAttributes {
//        TimerAttributes(totalTime: TimeInterval(10), name: "World", isTimer: Bool)
//    }
//}

extension TimerAttributes.ContentState {
//    fileprivate static var smiley: TimerAttributes.ContentState {
//        TimerAttributes.ContentState(emoji: "😀")
//     }
//     
//     fileprivate static var starEyes: FocusMonitorAttributes.ContentState {
//         TimerAttributes.ContentState(emoji: "🤩")
//     }
}
//
//#Preview("Notification", as: .content, using: TimerAttributes.preview) {
//    FocusMonitorLiveActivity()
//} contentStates: <#@MainActor () async -> [TimerAttributes.ContentState]#>
////} contentStates: {
//////    FocusMonitorAttributes.ContentState.smiley
//////    FocusMonitorAttributes.ContentState.starEyes
////}
