//
//  SwiftUIView.swift
//  simple-barometer
//
//  Created by Michael Johnson on 2/23/23.
//

import SwiftUI
import Charts

struct LabeledGauge: View {
    @State private var current = 29.9
    @State private var minValue = 29.0
    @State private var maxValue = 31.0

    var body: some View {
        ZStack {
            Gauge(value: current, in: minValue...maxValue) {
                Text("BPM")
            } currentValueLabel: {
                Text("\(current, specifier: "%.2f")")
            } minimumValueLabel: {
                Text("\(minValue, specifier: "%.2f")")
            } maximumValueLabel: {
                Text("\(maxValue, specifier: "%.2f")")
            }
            
            .gaugeStyle(.accessoryCircular)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(Color.pink)
    }
}

struct StyledGauge: View {
    
    @State private var current = 67.0
    @State private var minValue = 50.0
    @State private var maxValue = 170.0
    let gradient = Gradient(colors: [.green, .yellow, .orange, .red])

    var body: some View {
        Gauge(value: current, in: minValue...maxValue) {
            Image(systemName: "heart.fill")
                .foregroundColor(.red)
        } currentValueLabel: {
            Text("\(Int(current))")
                .foregroundColor(Color.green)
        } minimumValueLabel: {
            Text("\(Int(minValue))")
                .foregroundColor(Color.green)
        } maximumValueLabel: {
            Text("\(Int(maxValue))")
                .foregroundColor(Color.red)
        }
        .gaugeStyle(.accessoryCircularCapacity)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        LabeledGauge()
    }
}
