//
//  PeriodeuxWidget.swift
//  PeriodeuxWidget
//
//  Created by Sophie Kremer on 05.07.21.
//

import WidgetKit
import SwiftUI

struct ColorManager {
    static let highlightOrange  = Color("highlightOrange")
    static let backgroundOrange = Color("backgroundOrange")
    static let circleOrange     = Color("circleOrange")
    static let customTeal       = Color("customTeal")
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct PeriodeuxWidgetEntryView : View {
    
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: Provider.Entry
    
    var body: some View {
        switch family {
        case .systemMedium:
            MediumWidget()
        case .systemSmall:
            SmallWidget()
        default:
            SmallWidget()
        }
    }
    
}

struct SmallWidget: View {
    
    var body: some View {
        
        ZStack {
            Color(UIColor(ColorManager.backgroundOrange))
                .ignoresSafeArea()
            
//            GeometryReader { geo in
//                Image("backgroundPattern")
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: geo.size.width,
//                           height: geo.size.height,
//                           alignment: .center)
//            }
            
            HStack {
                
                Image("relaxed")
                    .padding(.leading, 10)
                
                VStack {
                    
                    ZStack {
                        
                        Circle()
                            .foregroundColor(ColorManager.customTeal)
                            .padding(.trailing, 10)
                            .frame(height: 30)
                        
                        Text("11").font(.system(.body, design: .rounded)).fontWeight(.bold)
                            .foregroundColor(Color.teal)
                            .padding(.trailing, 10)
                            
                    }
                    
                    ZStack {
                        
                        Circle()
                            .foregroundColor(ColorManager.circleOrange)
                            .padding(.trailing, 10)
                            .frame(height: 44)
                        
                        Text("5").font(.system(.title, design: .rounded)).fontWeight(.bold)
                            .foregroundColor(ColorManager.highlightOrange)
                            .padding(.trailing, 10)
                    }
                }
            }
        }
    }
}

struct MediumWidget: View {
    
    var body: some View {
        
        ZStack {
            Color(UIColor(ColorManager.backgroundOrange))
                .ignoresSafeArea()
            
            HStack {
                
                Image("relaxed")
                    .padding(.leading, 30)
                
                VStack {
                    
                    ZStack {
                        
                        Circle()
                            .foregroundColor(ColorManager.customTeal)
                            .frame(height: 30)
                        
                        Text("11").font(.system(.body, design: .rounded)).fontWeight(.bold)
                            .foregroundColor(Color.teal)

                            
                    }
                    
                    ZStack {
                        
                        Circle()
                            .foregroundColor(ColorManager.circleOrange)
                            .frame(height: 44)
                        
                        Text("5").font(.system(.title, design: .rounded)).fontWeight(.bold)
                            .foregroundColor(ColorManager.highlightOrange)
                    }
                }
                
                Image("sensitive")
                    .padding(.trailing, 30)
                  
            }
        }
        
    }
}

@main
struct PeriodeuxWidget: Widget {
    let kind: String = "PeriodeuxWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            
            PeriodeuxWidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemSmall, .systemMedium])
        .configurationDisplayName("Periodeux Widget")
        .description("This is a simple tracking visualisation.")
    }
}

//struct PeriodeuxWidget_Previews: PreviewProvider {
//    static var previews: some View {
//        PeriodeuxWidgetEntryView(entry: SimpleEntry(date: Date()))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}
