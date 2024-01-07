//
//  InspireMeWidget.swift
//  InspireMeWidget
//
//  Created by Rafael Meha on 06/01/2024.
//

import WidgetKit
import SwiftUI

struct InspireMePhrases {
    static let all = [
        "Keep pushing forward!",
        "Belive in yourself",
        "You can do it!",
        "You change the world by being yourself",
        "Everything is hard before it is easy",
        "Life is tough, but so are you",
    ]
}


struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), phrase: InspireMePhrases.all.randomElement() ?? "")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), phrase: InspireMePhrases.all.randomElement() ?? "")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        let currentDate = Date()
        for halfHourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: halfHourOffset * 1, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, phrase: InspireMePhrases.all.randomElement() ?? "")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let phrase: String
}


struct InspireMeWidgetEntryView: View {
    var entry: Provider.Entry
    var body: some View {
        HStack {
            Image(systemName: "heart.fill") // Example icon
                .resizable()
                .scaledToFit()
                .foregroundColor(Color("Heart"))
                .frame(width: 30, height:30) // Adjust size as needed
            
            Text(entry.phrase)
                .font(.system(size: 22, weight: .light, design: .serif)) // Adjust font size as needed
                .italic()
                .lineLimit(nil)
                .minimumScaleFactor(0.5)
                .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                .multilineTextAlignment(.leading)
        }
        .padding()
        .containerBackground(for: .widget) {
            Color("Color") // Make sure this color is defined in your assets
        }
    }
}




struct InspireMeWidget: Widget {
    let kind: String = "InspireMe"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            InspireMeWidgetEntryView(entry: entry)
                .padding()
        }
        .configurationDisplayName("InspireMe")
        .description("Add the widget your homes screen and get inspired!")
        .supportedFamilies([.systemMedium])
    }
}

#Preview(as: .systemMedium) {
    InspireMeWidget()
} timeline: {
    SimpleEntry(date: .now, phrase: "Believe in yourself!")
    SimpleEntry(date: .now, phrase: "You can do it!")
}

