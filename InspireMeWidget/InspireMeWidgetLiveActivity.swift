//
//  InspireMeWidgetLiveActivity.swift
//  InspireMeWidget
//
//  Created by Rafael Meha on 07/01/2024.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct InspireMeWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct InspireMeWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: InspireMeWidgetAttributes.self) { context in
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

extension InspireMeWidgetAttributes {
    fileprivate static var preview: InspireMeWidgetAttributes {
        InspireMeWidgetAttributes(name: "World")
    }
}

extension InspireMeWidgetAttributes.ContentState {
    fileprivate static var smiley: InspireMeWidgetAttributes.ContentState {
        InspireMeWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: InspireMeWidgetAttributes.ContentState {
         InspireMeWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: InspireMeWidgetAttributes.preview) {
   InspireMeWidgetLiveActivity()
} contentStates: {
    InspireMeWidgetAttributes.ContentState.smiley
    InspireMeWidgetAttributes.ContentState.starEyes
}
