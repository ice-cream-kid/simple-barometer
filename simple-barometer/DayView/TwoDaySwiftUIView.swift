//
//  TwoDaySwiftUIView.swift
//  simple-barometer
//
//  Created by Michael Johnson on 2/27/23.
//

import SwiftUI

struct TwoDaySwiftUIView: View {
    
weak var navigationController: UINavigationController?

    var body: some View {
        ZStack {
            Color.purple
                .ignoresSafeArea()
                  
                  // Your other content here
                  // Other layers will respect the safe area edges
          }
    }
}

struct TwoDaySwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        TwoDaySwiftUIView()
    }
}
