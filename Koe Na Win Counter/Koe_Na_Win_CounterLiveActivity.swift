//
//  Koe_Na_Win_CounterLiveActivity.swift
//  Koe Na Win Counter
//
//  Created by Kaung Min Khant on 12/28/23.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct Koe_Na_Win_CounterAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct Koe_Na_Win_CounterLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: Koe_Na_Win_CounterAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension Koe_Na_Win_CounterAttributes {
    fileprivate static var preview: Koe_Na_Win_CounterAttributes {
        Koe_Na_Win_CounterAttributes(name: "World")
    }
}

extension Koe_Na_Win_CounterAttributes.ContentState {
    fileprivate static var smiley: Koe_Na_Win_CounterAttributes.ContentState {
        Koe_Na_Win_CounterAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: Koe_Na_Win_CounterAttributes.ContentState {
         Koe_Na_Win_CounterAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: Koe_Na_Win_CounterAttributes.preview) {
   Koe_Na_Win_CounterLiveActivity()
} contentStates: {
    Koe_Na_Win_CounterAttributes.ContentState.smiley
    Koe_Na_Win_CounterAttributes.ContentState.starEyes
}
