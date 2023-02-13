//
//  CurrentPressureGaugeController.swift
//  simple-barometer
//
//  Created by Michael Johnson on 2/13/23.
//

import Foundation
import UIKit
import SwiftUI

struct CurrentPressureGauge: View {
    
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
        .gaugeStyle(.accessoryCircular)//(tint: gradient))
    }
}
