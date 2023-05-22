//
//  TwoDaySwiftUIView.swift
//  simple-barometer
//
//  Created by Michael Johnson on 2/27/23.
//

import SwiftUI
import Charts

struct TwoDaySwiftUIView: View {

    weak var navigationController: UINavigationController?
    @State private var localWeatherData: WeatherData!
    
    @State private var isDragging = false
    @State private var touchTitle = " "
    @State private var touchPointDate = Calendar.current.startOfDay(for: Date())
    @State private var touchPointPressure = 0.0
    
    private var threeDayArray  = [PressureHour]()
    private var eightDayArray =  [PressureHour]()
    
    init(navigationController : UINavigationController, weatherData : WeatherData) {
        _localWeatherData = State(initialValue: weatherData)
        threeDayArray = threeDayChartableData()
        eightDayArray = eightDayChartableData()
        
        //if nsuserdefault empty
        // write to default
    }
    
    var body: some View {

        VStack {
    
    //top panel
            GroupBox("Current Conditions") {}
            
    // 3-day line mark
            GroupBox(
                label: Label("3-Day View", systemImage: "barometer")
                    .labelStyle(.titleOnly)
                    .foregroundColor(.cyan)
            ) {
                Label(touchTitle, systemImage: "hand.point.up.left.fill")
                    .labelStyle(.titleOnly)
                    .frame(maxWidth: .infinity, alignment: .center)
                                
                Chart {
                    ForEach(threeDayArray) { hour in
                        LineMark(
                            x: .value("Time", hour.dateTime),
                            y: .value("Pressure", hour.pressure)
                        )
                        .interpolationMethod(.catmullRom)
                    }
                    RuleMark(x: .value("", touchPointDate))
                        .foregroundStyle(Color(isDragging ? UIColor.white : UIColor.clear))
                }
                
                .chartYScale(domain: .automatic(includesZero: false))
                .chartOverlay { proxy in
                    GeometryReader { geometry in
                        Rectangle().fill(.clear).contentShape(Rectangle())
                            .gesture(DragGesture(minimumDistance: 0)
                                .onChanged { value in
                                    displayTouchPointData(at: value.location,
                                                       proxy: proxy,
                                                       geometry: geometry)
                                    isDragging = true
                                }
                                .onEnded {_ in
                                    isDragging = false
                                }
                            )
                    }
                }
            }
            
    // 10-day line mark
            GroupBox("Last 1, Next 7 Day View") {
                
                Chart {
                    ForEach(eightDayChartableData()) { hour in
                        LineMark(
                            x: .value("Time", hour.dateTime),
                            y: .value("Pressure", hour.pressure)
                        )
                        .interpolationMethod(.catmullRom)
                    }
                }
                .chartYScale(domain: .automatic(includesZero: false))
            }
        }
    }
    
    struct PressureHour: Identifiable {
        let id = UUID()
        let dateTimeString : String
        let pressure : Double
        let dateTime : Date

        init(dateTimeString: String, pressure: Double) {
            self.dateTimeString = dateTimeString
            self.pressure = (pressure / 33.864)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd-HH:mm:ss"
            self.dateTime = dateFormatter.date(from: dateTimeString)!
        }
    }
    
    func threeDayChartableData() -> [PressureHour] {
        
        var pressureHoursToGraph : [PressureHour] = []

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        for day in localWeatherData.days {
                        
            let dayDate = dateFormatter.date(from: day.datetime)!
            let today = Calendar.current.startOfDay(for: Date())
            let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
            let tomorrowPlusOne = Calendar.current.date(byAdding: .day, value: 2, to: today)!

            if (dayDate == today || dayDate == tomorrow || dayDate == tomorrowPlusOne) {
                
                for hour in day.hours {
                    let dateTimeString = day.datetime.appending("-").appending(hour.datetime)
                    let ph = PressureHour(dateTimeString: dateTimeString, pressure: hour.pressure)
                    pressureHoursToGraph.append(ph)
                }
            }
        }
        
        return pressureHoursToGraph
    }
    
    func eightDayChartableData() -> [PressureHour] {
        
        var pressureHoursToGraph : [PressureHour] = []
        
        for day in localWeatherData.days {
            for hour in day.hours {
                let dateTimeString = day.datetime.appending("-").appending(hour.datetime)
                let ph = PressureHour(dateTimeString: dateTimeString, pressure: hour.pressure)
                pressureHoursToGraph.append(ph)
            }
        }
        
        return pressureHoursToGraph
    }
    
    private func displayTouchPointData(at location: CGPoint, proxy: ChartProxy, geometry: GeometryProxy) {
        
        let xPosition = location.x - geometry[proxy.plotAreaFrame].origin.x
        guard let xDate: Date = proxy.value(atX: xPosition) else {
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm" //EEEE, MMM d
        dateFormatter.timeZone = NSTimeZone.local
        
        let yPosition = location.y - geometry[proxy.plotAreaFrame].origin.y
        
        // we don't want the value of the TOUCHED YYY POSITION.
        // we need value of the pressure of the touched XXX position
        
        
//        (lldb) po threeDayArray
//        ▿ 72 elements
//          ▿ 0 : PressureHour
//            ▿ id : 0BFB3CA8-893F-411B-BDCF-628836F9D193
//              - uuid : "0BFB3CA8-893F-411B-BDCF-628836F9D193"
//            - dateTimeString : "2023-05-22-00:00:00"
//            - pressure : 30.11162296243799
//            ▿ dateTime : 2023-05-22 04:00:00 +0000
//              - timeIntervalSinceReferenceDate : 706420800.0
        
        guard let yPressure: Double = threeDayArray.first(where: { $0.dateTime == xDate})?.pressure else {

            return
        }
        
//        pressure = threeDayChartableData().first(where: { $0.dateTime == date})?.pressure
        
//        print(pressure)
        
        // limit to end of visible data!
        
        touchTitle = dateFormatter.string(from: xDate) + " " + String(format: "%.2f", yPressure)
        touchPointDate = xDate
        touchPointPressure = yPressure
    }
}


