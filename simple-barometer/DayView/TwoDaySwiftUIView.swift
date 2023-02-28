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
        let pressureHours = convertDataToDataEyeRoll()
        
        VStack {
            Chart {
                ForEach(pressureHours) { hour in
                    LineMark(
                        x: .value("Time", hour.dateString),
                        y: .value("Press", hour.pressure)
                    )
                }
            }
            .frame(height: 300)
        }
    }
    
    struct PressureHour: Identifiable {
        let id = UUID()
        let dateString : String
        let pressure : Double

        init(dateString: String, pressure: Double) {
            self.dateString = dateString
            self.pressure = pressure
        }
        
    }
    
    func convertDataToDataEyeRoll() -> [PressureHour] {
        
        var dummyArray : [PressureHour] = []
        
        for day in localWeatherData.days {
            for hour in day.hours {
                let ph = PressureHour(dateString: hour.datetime, pressure: hour.pressure)
                dummyArray.append(ph)
                
            }
        }
        
        return dummyArray
    }
}

//struct TwoDaySwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
////        TwoDaySwiftUIView()
//    }
//}


//            VStack {
//
//                Chart {
//                    ForEach(londonWeatherData) { item in
//                        LineMark(
//                            x: .value("Month", item.date),
//                            y: .value("Temp", item.temperature)
//                        )
//                    }
//                }
//                .frame(height: 300)
//
//            }
//        }

//        var body: some View {
//                VStack {
//                    Chart {
//                        ForEach(0..<localWeatherData.days.count) { Day in
//                            ForEach(0..<Day.hours.count) { Hour in
//                                LineMark(
//                                    x: .value("Date", Hour.datetime),
//                                    y: .value("Press", Hour.pressure)
//                                )
//
//                            }
//                        }
//                    }
//                    .frame(height: 300)
//                }
//            }


struct WeatherDataExample: Identifiable {
    let id = UUID()
    let date: Date
    let temperature: Double

    init(year: Int, month: Int, day: Int, temperature: Double) {
        self.date = Calendar.current.date(from: .init(year: year, month: month, day: day)) ?? Date()
        self.temperature = temperature
    }
}

let londonWeatherData = [WeatherDataExample(year: 2021, month: 7, day: 1, temperature: 19.0),
                        WeatherDataExample(year: 2021, month: 8, day: 1, temperature: 17.0),
                        WeatherDataExample(year: 2021, month: 9, day: 1, temperature: 17.0),
                        WeatherDataExample(year: 2021, month: 10, day: 1, temperature: 13.0),
                        WeatherDataExample(year: 2021, month: 11, day: 1, temperature: 8.0),
                        WeatherDataExample(year: 2021, month: 12, day: 1, temperature: 8.0),
                        WeatherDataExample(year: 2022, month: 1, day: 1, temperature: 5.0),
                        WeatherDataExample(year: 2022, month: 2, day: 1, temperature: 8.0),
                        WeatherDataExample(year: 2022, month: 3, day: 1, temperature: 9.0),
                        WeatherDataExample(year: 2022, month: 4, day: 1, temperature: 11.0),
                        WeatherDataExample(year: 2022, month: 5, day: 1, temperature: 15.0),
                        WeatherDataExample(year: 2022, month: 6, day: 1, temperature: 18.0)]

