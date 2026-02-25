import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), title: "SchedBuilder", message: "Loading...", classes: [])
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), title: "SchedBuilder", message: "Loading...", classes: [])
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        // Get data from UserDefaults shared with Flutter app
        let sharedDefaults = UserDefaults(suiteName: "group.com.example.addu_schedbuilder_flutter")

        let title = sharedDefaults?.string(forKey: "widget_title") ?? "SchedBuilder"
        let message = sharedDefaults?.string(forKey: "widget_message") ?? "No schedule set"
        let classCount = sharedDefaults?.integer(forKey: "class_count") ?? 0

        var classes: [ClassInfo] = []

        for i in 0..<min(classCount, 3) {
            let subject = sharedDefaults?.string(forKey: "class_\(i)_subject") ?? ""
            let code = sharedDefaults?.string(forKey: "class_\(i)_code") ?? ""
            let time = sharedDefaults?.string(forKey: "class_\(i)_time") ?? ""
            let room = sharedDefaults?.string(forKey: "class_\(i)_room") ?? ""

            classes.append(ClassInfo(subject: subject, code: code, time: time, room: room))
        }

        let entry = SimpleEntry(date: Date(), title: title, message: message, classes: classes)

        // Update every 30 minutes
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 30, to: Date())!
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))

        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let title: String
    let message: String
    let classes: [ClassInfo]
}

struct ClassInfo {
    let subject: String
    let code: String
    let time: String
    let room: String
}

struct SchedBuilderWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Header
            VStack(alignment: .leading, spacing: 2) {
                Text(entry.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                Text(entry.message)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.bottom, 4)

            // Classes or empty state
            if entry.classes.isEmpty {
                Spacer()
                Text("Set a schedule to see classes here")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                Spacer()
            } else {
                ForEach(0..<entry.classes.count, id: \.self) { index in
                    ClassItemView(classInfo: entry.classes[index])
                }
                Spacer()
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.12, green: 0.12, blue: 0.12))
    }
}

struct ClassItemView: View {
    let classInfo: ClassInfo

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(classInfo.subject)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .lineLimit(1)

            Text(classInfo.code)
                .font(.caption)
                .foregroundColor(.gray)

            Text(classInfo.time)
                .font(.caption)
                .foregroundColor(.gray)

            Text("Room: \(classInfo.room)")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 0.16, green: 0.16, blue: 0.16))
        .cornerRadius(8)
    }
}

@main
struct SchedBuilderWidget: Widget {
    let kind: String = "SchedBuilderWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            SchedBuilderWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("SchedBuilder")
        .description("View your daily class schedule")
        .supportedFamilies([.systemMedium, .systemLarge])
    }
}

struct SchedBuilderWidget_Previews: PreviewProvider {
    static var previews: some View {
        SchedBuilderWidgetEntryView(entry: SimpleEntry(
            date: Date(),
            title: "Monday",
            message: "3 classes today",
            classes: [
                ClassInfo(subject: "Computer Science", code: "CS101", time: "8:00 AM - 9:30 AM", room: "204"),
                ClassInfo(subject: "Mathematics", code: "MATH201", time: "10:00 AM - 11:30 AM", room: "305")
            ]
        ))
        .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
