//
//  GaugeView.swift
//  simple-barometer
//
//  Created by Michael Johnson on 2/13/23.
//

import UIKit

class GaugeView: UIView {

    var outerBezelColor = UIColor(red: 0, green: 0.5, blue: 1, alpha: 1)
    var outerBezelWidth: CGFloat = 10

    var innerBezelColor = UIColor.systemRed
    var innerBezelWidth: CGFloat = 5

    var insideColor = UIColor.white
    
    var segmentWidth: CGFloat = 20
    var segmentColors = [UIColor(red: 0.7, green: 0, blue: 0, alpha: 1), UIColor(red: 0, green: 0.5, blue: 0, alpha: 1), UIColor(red: 0, green: 0.5, blue: 0, alpha: 1), UIColor(red: 0, green: 0.5, blue: 0, alpha: 1), UIColor(red: 0.7, green: 0, blue: 0, alpha: 1)]
    
    var totalAngle: CGFloat = 270
    var rotation: CGFloat = -135
    
    func drawBackground(in rect: CGRect, context ctx: CGContext) {
        // draw the outer bezel as the largest circle
        outerBezelColor.set()
        ctx.fillEllipse(in: rect)

        // move in a little on each edge, then draw the inner bezel
        let innerBezelRect = rect.insetBy(dx: outerBezelWidth, dy: outerBezelWidth)
        innerBezelColor.set()
        ctx.fillEllipse(in: innerBezelRect)

        // finally, move in some more and draw the inside of our gauge
        let insideRect = innerBezelRect.insetBy(dx: innerBezelWidth, dy: innerBezelWidth)
        insideColor.set()
        ctx.fillEllipse(in: insideRect)
    }
    
    override func draw(_ rect: CGRect) {
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        drawBackground(in: rect, context: ctx)
    }

}
