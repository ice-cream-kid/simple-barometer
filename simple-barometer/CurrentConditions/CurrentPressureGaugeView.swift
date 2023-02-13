//
//  CurrentPressureGaugeView.swift
//  simple-barometer
//
//  Created by Michael Johnson on 2/13/23.
//

import Foundation
import UIKit
import SwiftUI

struct CurrentPressureGaugeView : View {
    
    @State private var current = 30.0
    @State private var minValue = 29.0
    @State private var maxValue = 31.0
    
    let gradient = Gradient(colors: [.green, .yellow, .orange, .red])

    var body: some View {
        
        Gauge(value: current, in: minValue...maxValue) {
            Image(systemName: "barometer")
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
        .gaugeStyle(.accessoryCircular)//(tint: gradient))
    }
    
    
    init(current: Double = 30.0, minValue: Double = 29.0, maxValue: Double = 31.0) {
        self.current = current
        self.minValue = minValue
        self.maxValue = maxValue
    }
}
