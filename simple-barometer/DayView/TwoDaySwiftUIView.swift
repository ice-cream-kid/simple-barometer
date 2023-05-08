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
    @State var localWeatherData: WeatherData!
    
    init(navigationController : UINavigationController, weatherData : WeatherData) {
        _localWeatherData = State(initialValue: weatherData)
    }
    
    var body: some View {

        VStack {
    
    //top panel
            
            GroupBox("Current Conditions") {

            }
            .padding()
    
            
    // 3-day line mark
            GroupBox("3-Day View") {
                
                Chart {
                    ForEach(threeDayChartableData()) { hour in
                        LineMark(
                            x: .value("Time", hour.dateTime),
                            y: .value("Pressure", hour.pressure)
                        )
                        .interpolationMethod(.catmullRom)
                        //lowest current, highest current.
//                        .chartYScale(domain: [0, 100])
                    }
                }
                .chartYScale(domain: .automatic(includesZero: false))
            }
            .padding()
            
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
            .padding()
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

            let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)!
            let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
                        
            if (dayDate == yesterday || dayDate == Date() || dayDate == tomorrow) {
                
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
    
    
}


